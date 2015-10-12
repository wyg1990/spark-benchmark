#!/bin/bash
#SQL_CMD=$SPARK_HOME/bin/beeline

echo 'run test queries'
#$SQL_CMD -u jdbc:hive2://localhost:10000 -f $WORKDIR/sql/queryTest.sql
$SQL_CMD -f $WORKDIR/sql/queryTest.sql
