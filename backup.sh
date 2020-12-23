#!/bin/bash

USER="root"
PASSWORD="S6sJbAqH"
HOST="db"

databases=`mysql -h $HOST -u $USER -p$PASSWORD -e "SHOW DATABASES;" | tr -d "| " | grep -v Database`

for db in $databases; do
    if [[ "$db" != "information_schema" ]] && [[ "$db" != "performance_schema" ]] && [[ "$db" != "mysql" ]] && [[ "$db" != _* ]] ; then
        echo "Dumping database: $db"
        mysqldump --skip-dump-date -h $HOST -u $USER -p$PASSWORD --databases $db > /backup/$db.sql
    fi
done
