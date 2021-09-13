#!/bin/bash

clear
cat logsMulesoft/mule-qtc*.log | grep "$1" | grep "migration" | grep "MIGRATION FINAL RESPONSE" | cut -d '"' -f 30 | sort | uniq > migrationsOk.txt
cat logsMulesoft/mule-qtc*.log | grep "$1" | grep -v "delete" | grep "migration" | grep "BEFORE REQUEST" | cut -d '"' -f 4 | sort | uniq > migrationsTotals.txt


count=0
countTest=0
echo -e "\e[1;33m__________________ SUCCESS MIGRATIONS____________________\e[0m"
cat migrationsOk.txt |  while read line
do
	grep -q -w $line migrationsOk.txt
	if [ $line != "250408" ];
	then
		echo -n -e "\e[1;32m""$(printf '%6s' "$line" )""\t\e[0m";
		count= $count + 1;
	else
		echo -n -e "$(printf '%6s' "$line" )""\t";
		countTest= $countTest + 1;
	fi
done
echo ""
echo -e "\e[1;32mCLIENTS: " $count "\e[0m"
echo -e "\e[1;32mTESTS: " $countTest "\e[0m"
counterOk=`cat migrationsOk.txt | wc -l`
echo -e "\e[1;32mTOTALS: " $counterOk "\e[0m"

echo -e "\e[1;33m__________________ FAILED MIGRATIONS____________________\e[0m"
#count=0
cat migrationsTotals.txt |  while read line
do
	grep -q -w $line migrationsOk.txt
	if [ $? != 0 ];
	then
		echo -n -e "\e[1;31m""$(printf '%6s' "$line" )""\t\e[0m"
		#count=$(( count+1 ))
	fi
done
echo ""
#echo -e "\e[1;31mTOTALS: " $count"\e[0m"
counterTotal=`cat migrationsTotals.txt | wc -l`
echo -e "\e[1;31mTOTALS: " $(( counterTotal-counterOk  )) "\e[0m"


echo "TOTAL PROCESED: " $counterTotal
echo ""
echo ""

echo "_______________ SUCCESS TRANSACTIONS _______________"
echo "TAE:		" `cat logsMulesoft/mule-qtc*.log  | grep "$1" | grep "tae" | grep "\"000\"" | wc -l`
echo "DATA:		" `cat logsMulesoft/mule-qtc*.log  | grep "$1" | grep "data" | grep "\"000\"" | wc -l`
echo "BILLPAYMENT:	" `cat logsMulesoft/mule-qtc*.log  | grep "$1" | grep "billpayment" | grep "\"000\"" | wc -l`
echo "CASHCOLLECTION:	" `cat logsMulesoft/mule-qtc*.log  | grep "$1" | grep "cashcollection" | grep "\"000\"" | wc -l`
echo "DEPOSITS:	" `cat logsMulesoft/mule-qtc*.log  | grep "$1" | grep "deposit" | grep "\"000\"" | wc -l`
echo "OLC:		" `cat logsMulesoft/mule-qtc*.log  | grep "$1" | grep "olc" | grep "\"000\"" | wc -l`


