#!/bin/bash

# create tables with certain format
echo "create tables with certain format"
$SQL_CMD -f $WORKDIR/sql/dropTable.sql --master local
$SQL_CMD -f $WORKDIR/sql/createTableWithFormat.sql --master local

# prepare data with certain format
echo "prepare data with certain format"
$SQL_CMD -f $WORKDIR/sql/loadData.sql --master yarn
