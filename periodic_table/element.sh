
if [[ -z $1 ]]
then 
  echo Please provide an element as an argument.
  exit
fi

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
SEARCH_KEY=$1 
JOIN_TABLE="elements el LEFT JOIN properties p USING(atomic_number) LEFT JOIN types t USING(type_id)"

CONDITION=""
if [[ $SEARCH_KEY =~ ^[0-9]+$ ]]
then
  CONDITION="el.atomic_number=$SEARCH_KEY"
else
  CONDITION="el.symbol = '$SEARCH_KEY' or el.name='$SEARCH_KEY'"
fi

FILTER="el.atomic_number,el.symbol,el.name,p.atomic_mass,p.melting_point_celsius, p.boiling_point_celsius, t.type"
FULL_QUERY="SELECT $FILTER FROM $JOIN_TABLE WHERE $CONDITION;"

ELEMENT_INFO=$($PSQL "$FULL_QUERY")

if [[ -n $ELEMENT_INFO ]]
then
  while IFS="|" read ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS TYPE
  do
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
  done <<< $ELEMENT_INFO
else
  echo "I could not find that element in the database."
fi

