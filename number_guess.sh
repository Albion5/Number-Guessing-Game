#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=game -t --no-align -c"
MAIN_LOOP() {
  if [[ -n "$1" ]]
  then
    echo -e "\n$1"
  fi 
  read GUESS
  (( GUESSES+=1 ))
  if [[ "$GUESS" =~ ^[0-9]+$ ]]
  then
    if [[ $GUESS -eq $NUMBER ]]
    then
      echo you won!
    else
      MAIN_LOOP "you didn't guess"
    fi
  else
    MAIN_LOOP "try again"
  fi
}


GET_USER_GAME_HISTORY() {
  echo "$($PSQL "SELECT game_id FROM games WHERE user_id = $1")"
}


GAME() {
  if [[ -n "$1" ]]
  then
    echo -e "\n$1"
  fi
  echo Enter your username:
  read NAME
  if [[ ${#NAME} -gt 22 ]]
  then
    GAME "Your name should be 22 or less characters long."
  else
    USER_ID=$(LOGIN "$NAME")
    if [[ -z $USER_ID ]]
    then
      USER_ID=$(REGISTER "$NAME")
      echo "Welcome, $NAME! It looks like this is your first time here."
    else
      GAME_HISTORY=$(GET_USER_GAME_HISTORY $USER_ID)
      echo Welcome back, $NAME! $GAME_HISTORY
    fi
    GUESSES=0
    NUMBER=5
    MAIN_LOOP "Guess the secret number between 1 and 1000:"
    echo $GUESSES
  fi
}

REGISTER() {
  $PSQL "INSERT INTO users(name) VALUES('$1')"
  echo $(LOGIN "$1")
  
}

LOGIN() {
  echo $($PSQL "SELECT user_id FROM users WHERE name='$1'")
}

GAME "Welcome to Number Guessing Game!"




