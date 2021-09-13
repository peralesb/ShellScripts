#!/bin/sh

export SSHPASS=Z8yV5WvNwWLOqLhzmtAP2a3XTnWFnztf
blmFTPUser=kineto_santander
santanderFTPUser=e2660569

workPath=/home/ubuntu/santander/scripts
cd $workPath
#####################################  TA3 #########################################
#echo `pwd`
currentDate=`date '+%Y%m%d'`
ftpLocal=ftpSantander
echo `date` "***** START DOWNLOAD *****"

# Get the last file uploades
lastUploaded=`cat last.txt | cut -d '.' -f 1 | cut -c12-23`
if [ -z "$lastUploaded"  ]
then
	lastUploaded=currentDate
fi

#If download from yesterday (NOT today)
if test "$1" = "yesterday"
then
	currentDate=$(($currentDate - 1))
fi
# Download from Santander SFTP
#sshpass -e sudo sftp $santanderFTPUser@buzon.santander.com.mx -vv << EOF
#lcd $ftpLocal
#mget *$currentDate*.zip
#EOF
#echo "***** END DOWNLOAD AT:" `date` "*****"

#sudo sftp -n -v >> filetransfer.log 2>&1 buzon.santander.com.mx << EOF
#sudo sftp $santanderFTPUser@buzon.santander.com.mx  << EOF
#sudo ftp -n -v >> filetransfer.log 2>&1 buzon.santander.com.mx << EOF
##sshpass -e sudo sftp $santanderFTPUser@buzon.santander.com.mx -vv << EOF
##	binary
##	lcd $ftpLocal
##	passive
##	mget *$currentDate*.zip
##	quit
##EOF



# requiere entrar al directorio cd reslpaldo de kineto para tomar los procesados
echo `date` "Current date to download" $currentDate
sudo sftp -i e2660569.key e2660569@170.169.130.85 << EOF
binary
lcd $ftpLocal
passive
cd respaldo
mget *$currentDate*.zip
quit
EOF

echo `date` "***** START UPLOAD *****"
## Upload file only if by name is more recent than lastUploaded
#echo `ls -1 $ftpLocal/*.zip | cut -d '/' -f 2 | cut -d '.' -f 1`
echo `date` "Last uploaded" $lastUploaded
cd $ftpLocal
for file in `ls -1 *.zip | cut -d '.' -f 1 | cut -c12-23`
do
	#echo $(($file > $lastUploaded)) $file $lastUploaded
	if  [ $(($file > $lastUploaded)) -eq 1 ]
	then
		echo `date` "Uploading..." $file
#sshpass -e sudo sftp $blmFTPUser@18.208.66.109 << EOF
#aqui vienen los datos de AEON para la subida delos files
#requiere entrar a losal directorio de entradas de el buzon de AEON para que procese la info de la cuenta de kineto cd entradas
sudo sftp -i ../e0805866.key e0805866@170.169.130.85  << EOF
cd respaldo
echo "Uploaded..." $file
EOF

fi
done

echo `date` "***** The last file uploaded was:" `ls -1 -t *.zip | head -1` "*****"
#Save the last by name file downloaded
sudo ls -1 -t *.zip | sudo head -1  > $workPath/last.txt
cd ..


#################### MAINTAIN ########################
daysHistory=2
dateToDelete=`echo *$(($currentDate - $daysHistory))*.zip*`
echo `date` "***** MANTAIN ***** DATE TO DELETE: " $dateToDelete
rm -fv $ftpLocal/*$dateToDelete*.zip
find ./$ftpLocal/*.zip -mtime +$(($daysHistory-1)) -type f -delete
echo `date` "***** END *****"
