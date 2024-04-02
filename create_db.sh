#! /bin/bash
USER=freecodecamp
DEFAULT_DB_NAME=postgres
DB_NAME=$1
if [[ -z $DB_NAME ]]
then
    DB_NAME=game
fi
PSQL="psql --username=$USER --dbname=$DEFAULT_DB_NAME --no-align --tuples-only -c"
DB_EXISTS=$($PSQL "SELECT 1 FROM pg_database WHERE datname = '$DB_NAME'")
if [[ -z $DB_EXISTS ]]
then
    echo "$($PSQL "CREATE DATABASE $DB_NAME")"
fi


PSQL="psql --username=$USER --dbname=$DB_NAME --no-align --tuples-only -f"
echo "$($PSQL create_db.sql)"