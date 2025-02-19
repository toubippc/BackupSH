#!/bin/bash

username=$1;
host=$2;
passwd=$3;
dbname=$4;
outputFile=$5;

if [[ $1 = "help" || $1 = "-h" ]]
then
	echo "Exemple : mysqlBackup root 127.0.0.1 superpassword myDB /media/DATA/zabbix.sql"
	exit 0;
fi

if [ -z $username ] || [ -z $host ] || [ -z $passwd ] || [ -z $dbname ] || [ -z $dbname ] || [$outputFile ] 
then
	echo "Bad syntax or parameters, type help or -h ";
	exit 0;
fi
echo "Execute : mysqldump -u ${username} -h $host -p${passwd} --verbose --single-transaction ${dbname} > ${outputFile}";
read -p "Y(yes) | N(no) ? : " response;

if [[ $response = "Y" ]]
then
	mysqldump -u ${username} -h $host -p${passwd} --verbose --single-transaction ${dbname} > ${outputFile}
	exit 0;
fi



# mysqldump -u root -h 127.0.0.1 -pTrustNo1*  --single-transaction zabbix > zabbix.sql

