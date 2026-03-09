#! /bin/bash


echo -e "\n~~~~~ MY SALON ~~~~~"

PSQL="psql --username=freecodecamp --dbname=salon -t --no-align -c"

MAIN_MENU(){
  if [[ $1 ]]
  then
    echo -e $1
  else
    echo -e "\nWelcome to My Salon, how can I help you?"
  fi
  
  $PSQL "SELECT * FROM services" |  while IFS="|" read -r SERVICE_ID SERVICE_NAME
  do
    echo "$SERVICE_ID) $SERVICE_NAME"
  done 
  
  read SERVICE_ID_SELECTED 

  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  if [[ -z $SERVICE_NAME ]]
  then
    MAIN_MENU "\nI could not find that service. What would you like today?"
    return 
  fi 

  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE 

  CUSTOMER=$($PSQL "SELECT customer_id, name FROM customers WHERE phone='$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER ]]
  then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME

    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name,phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
    if [[ $INSERT_CUSTOMER_RESULT == "INSERT 0 1" ]]
    then
      CUSTOMER=$($PSQL "SELECT customer_id, name FROM customers WHERE phone='$CUSTOMER_PHONE'")
    fi
  fi

  IFS="|" read -r CUSTOMER_ID CUSTOMER_NAME <<< "$CUSTOMER"

  echo -e "\nWhat time would you like your $SERVICE_NAME, Fabio?"

  read SERVICE_TIME

  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
  if [[ $INSERT_APPOINTMENT_RESULT == "INSERT 0 1" ]]
  then
    echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
  fi

}


MAIN_MENU