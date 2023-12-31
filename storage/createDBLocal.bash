#!/bin/bash

JAVA="/opt/jdk-20.0.1/bin/java"
JAVAC="/opt/jdk-20.0.1/bin/javac"

# create database if it doesn't already exist
if [ ! -f /virtual/$USER/URLShortner/data.db ]; then
	mkdir -p /virtual/$USER/URLShortner
	# rm -f /virtual/$USER/URLShortner/data.db
	sqlite3 /virtual/$USER/URLShortner/data.db < storage/schema.sql
fi

# populate database if $1 is a given number
if [ "$1" != "" ]; then
	$JAVAC storage/Populate.java
	$JAVA -classpath ".:storage/sqlite-jdbc-3.39.3.0.jar" storage/Populate.java "jdbc:sqlite:/virtual/$USER/URLShortner/data.db" $1
fi
