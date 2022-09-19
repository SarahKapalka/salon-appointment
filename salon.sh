#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
MENU() {
echo -e "1) stupid\n2) dumb\n3) loser"
read SERVICE_ID_SELECTED
}
MENU

case $SERVICE_ID_SELECTED in
1)
  SERVICE_ID_SELECTED=1;;
2)
  SERVICE_ID_SELECTED=2;;
3)
  SERVICE_ID_SELECTED=3;;
*)
  MENU;;
esac

echo "What's your phone number?"
read CUSTOMER_PHONE
CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone ='$CUSTOMER_PHONE'")
if [[ -z $CUSTOMER_NAME ]]
then
  echo "I don't have a record for that phone number, what's your name?"
  read CUSTOMER_NAME
  INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
  
fi
SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED;")
CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone ='$CUSTOMER_PHONE'")
echo "What time would you like your$SERVICE_NAME,$CUSTOMER_NAME?"
read SERVICE_TIME

INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES('$CUSTOMER_ID', '$SERVICE_ID_SELECTED', '$SERVICE_TIME')")


echo "I have put you down for a$SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
    