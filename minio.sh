#!/bin/bash

# Validate parameters
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ] || [ -z "$5" ]; then
    echo "Usage: $0 <DB_HOST> <DB_PASSWORD> <DB_NAME> <MINIO_USER> <MINIO_PASSWORD>"
    exit 1
fi

# Assign input parameters
DB_HOST=$1
DB_PASSWORD=$2
DB_NAME=$3
MINIO_USER=$4
MINIO_PASSWORD=$5

# export mysql password
export MYSQL_PWD=$DB_PASSWORD

# Generate timestamp and filename
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
NAME="backup_$TIMESTAMP.sql"

# Start backup process
echo "Start Backup..."
mysqldump -u root -h $DB_HOST $DB_NAME > /tmp/$NAME
if [ $? -ne 0 ]; then
    echo "Backup failed!"
    exit 2
fi
echo "Backup successful."

# Start uploading process
echo "Start Uploading..."
mc alias set myminio http://minio:9001 $MINIO_USER $MINIO_PASSWORD
mc cp /tmp/$NAME myminio/testdb
if [ $? -ne 0 ]; then
    echo "Upload failed!"
    exit 3
fi
echo "Uploading successful."
