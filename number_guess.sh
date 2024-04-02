#!/bin/bash

MAIN_LOOP() {
  # later
  echo "Game started"
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
    GAME "Your name should be 22 or less charachters long."
  else
    USER_ID=$(LOGIN "$NAME")
    if [[ -z $USER_ID ]]
    then
      USER_ID=$(REGISTER "$NAME")
      echo "Welcome, $USER_ID! It looks like this is your first time here."
    else
      echo Welcome back, $USER_ID!
    fi

    MAIN_LOOP
  fi
}

REGISTER() {
  echo 5
}

LOGIN() {
  echo
}

GAME "Welcome to Number Guessing Game!"




