#!/bin/bash

# drop old tables generated before
echo 'drop old tables generated before'
$SQL_CMD -f $WORKDIR/sql/dropAllTable.sql

# create tables
echo 'create tables based on source data'
$SQL_CMD -f $WORKDIR/sql/createTable.sql --master local
