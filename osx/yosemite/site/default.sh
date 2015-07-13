#! /bin/bash
groupDir=`cd $siteDir; cd ../; pwd`

Q1="USE $DB_NAME;"
Q2="INSERT INTO groups (name,starting_path,starting_port) VALUES ('Default', '$groupDir', $port);"
Q3="INSERT INTO sites (group_id, name, path, uuid, port, status, readyFlag) VALUES (1, 'Dasher', '$siteDir/public', 'dasher', $port, 'Complete', 1);"
SQL="${Q1}${Q2}${Q3}"

$MYSQL -u"$DB_USER" -p"$DB_PASS" -e "$SQL"