#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
  # $PSQL "TRUNCATE TABLE teams"
  # $PSQL "TRUNCATE TABLE games"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

count = 0 
# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv | while IFS=, read -r YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if (( count == 0 )) # skip header 
  then
    (( count++ ))
    continue
  fi

  echo $YEAR $ROUND $WINNER $OPPONENT $WINNER_GOALS $OPPONENT_GOALS

  # get winner id
  WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
  if [[ -z $WINNER_ID ]]
  then
    INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
    if [[ $INSERT_TEAM_RESULT == "INSERT 0 1" ]]
    then
      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    fi
  fi

  # get opponent id
  OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
  if [[ -z $OPPONENT_ID ]]
  then
    INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
    if [[ $INSERT_TEAM_RESULT == "INSERT 0 1" ]]
    then
      OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    fi
  fi

  # insert data into games
  # insert year, round, winner_id, opponent_id, winner_goals, opponent_goals
  INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
  if [[ $INSERT_GAME_RESULT == "INSERT 0 1" ]]
  then
    echo game $WINNER vs $OPPONENT inserted into database
  fi
done

echo "teams:"
echo "$($PSQL "SELECT * FROM teams")"
echo "games:"
echo "$($PSQL "SELECT * FROM games")"