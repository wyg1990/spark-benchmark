#!/bin/bash
# Set your Spark Home here
SPARK_HOME=/home/spark/spark-1.4.1-bin-hadoop2.4

# set your location for test data here
LOCATION="/user/spark/tpc_1t_act"

# set the table format here
FORMAT=parquet
DB=tpcds_1t_$FORMAT

# cmd && paramters
JAROPT="--jars /home/spark/mysql-connector-java-5.1.34-bin.jar"
HIVEOPT="--hivevar LOCATION=$LOCATION --hivevar DB=$DB --hivevar FORMAT=$FORMAT"

SQL_CMD="$SPARK_HOME/bin/spark-sql $JAROPT $HIVEOPT"
SUBMIT_CMD="$SPARK_HOME/bin/spark-submit $JAROPT $HIVEOPT"

WORKDIR=`pwd`
