#!/bin/bash


PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo -e "\nEnter your username:"

read USERNAME

USER_DATA=$($PSQL "SELECT games_played, best_game FROM users WHERE username='$USERNAME'")
GAME_COUNT=0
BEST_GUESS=""
NEW_USER=false


if [[ -n $USER_DATA ]]
then
  IFS="|" read GAME_COUNT BEST_GUESS <<< "$USER_DATA"
  echo -e "\nWelcome back, $USERNAME! You have played $GAME_COUNT games, and your best game took $BEST_GUESS guesses."
else 
  NEW_USER=true
  echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."
  
fi

RANDOM_NUMBER=$(( (RANDOM % 1000)+1 ))
ATTEMPT=0

GUESS_GAME(){
  if [[ -n $1 ]]
  then
    echo -e "$1"
  else 
    echo -e "Guess the secret number between 1 and 1000:"
  fi

  ((ATTEMPT++))

  read GUESS_INPUT
  if [[ ! $GUESS_INPUT =~ ^[0-9]+$ ]]
  then
    GUESS_GAME "\nThat is not an integer, guess again:"
    return
  fi

  if (( $GUESS_INPUT > $RANDOM_NUMBER ))
  then
    GUESS_GAME "\nIt's lower than that, guess again:"
    return 
  fi

  if (( $GUESS_INPUT < $RANDOM_NUMBER ))
  then 
    GUESS_GAME "\nIt's higher than that, guess again:"
    return
  fi

  if (( $GUESS_INPUT == $RANDOM_NUMBER ))
  then
    #check attempt < best guess
    #if true store to db
    if [[ -z $BEST_GUESS || $ATTEMPT -lt $BEST_GUESS ]]
    then
      BEST_GUESS=$ATTEMPT
    fi
    
    #increment game count as well
    ((GAME_COUNT++))

    if $NEW_USER
    then
      INSERT_USER_RESULT=$($PSQL "INSERT INTO users(username,games_played,best_game) values('$USERNAME', $GAME_COUNT, $BEST_GUESS)")
    else
      UPDATE_USER_RESULT=$($PSQL "UPDATE users SET games_played=$GAME_COUNT, best_game=$BEST_GUESS WHERE username='$USERNAME'")
    fi

    echo "You guessed it in $ATTEMPT tries. The secret number was $RANDOM_NUMBER. Nice job!"
  fi
}

GUESS_GAME 
