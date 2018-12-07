#!/bin/bash
# The command below will exit the system in case of error
set -e
echo "Hello World!"

dirname="archive"
current_time=$(date "+%Y.%m.%d-%H.%M.%S")
echo "Current Time : $current_time"


# Creating a archiving directory
mkdir -p -- $dirname.$current_time

for entry in $1/*
do
  # echo "$entry"
  # Removing the extension of file recived
  name=${entry%%[.]*}
  # echo $name
  # Removing the path before the name
  name2=$(basename $name) 
  echo $name2
  # Creating database and importing the file

  echo "$1/$name2.sql"
  mysql -u root -p$2 -Bse "CREATE DATABASE $name2;"
  mysql -u root -p$2 "$name2" < "$1/$name2.sql"

  # After successfully importing moving the file to archive folder
  mv "$entry" "./$dirname.$current_time/"



done
