#!/bin/sh


workPath=/home/ubuntu
renewLicensePath=$workPath/MuleRenewLicense
runningPath_3=$workPath/mule-enterprise-standalone-3.9.2
runningPath_4=$workPath/mule-enterprise-standalone-4.1.5

cd $workPath


echo `date '+%Y%m%d:%H%M%S'` ": ################### STARTING RENEW LICENSE OF 3.X KERNEL VERSION ######################"
#Stop productive service
echo `date '+%Y%m%d:%H%M%S'` ": ****************** Stopping productive service"
cd  $runningPath_3/bin
./mule stop
#Unpack a clear mule kernel file
echo `date '+%Y%m%d:%H%M%S'` ": ****************** Unpacking a clear mule kernel file"
cd $renewLicensePath
unzip mule-ee-distribution-standalone-3.9.2.zip -d $renewLicensePath/tmp/
#Run/Stop the fresh distribution to generate the new trial license
echo `date '+%Y%m%d:%H%M%S'` ": ****************** Running/Stopping the fresh distribution to generate the new trial license"
cd $renewLicensePath/tmp/mule-enterprise-standalone-3.9.2/bin
./mule start
sleep 60  # wait 60 secs to start the fresh distribution
./mule stop
#sleep 60 # wait 60 secs to full stopping
#Save the old license and set the new one
echo `date '+%Y%m%d:%H%M%S'` ": ****************** Saving the old license and set the new"
mv $runningPath_3/conf/muleLicenseKey.lic $renewLicensePath/tmp/muleLicenseKey.lic_`date '+%Y%m%d:%H%M%S'`
cp $renewLicensePath/tmp/mule-enterprise-standalone-3.9.2/conf/muleLicenseKey.lic $runningPath_3/conf/
#Delete the fresh distribution
cd $renewLicensePath/tmp/
rm -fr mule-enterprise-standalone-3.9.2
#Star the service
echo `date '+%Y%m%d:%H%M%S'` ": ****************** Starting the productive service"
cd $runningPath_3/bin
./mule -verifyLicense
./mule start
echo `date '+%Y%m%d:%H%M%S'` ": ################### END RENEW LICENSE OF 3.X KERNEL VERSION ######################"


echo `date '+%Y%m%d:%H%M%S'` ": ################### STARTING RENEW LICENSE OF 4.X KERNEL VERSION ######################"
#Stop productive service
echo `date '+%Y%m%d:%H%M%S'` ": ****************** Stopping productive service"
cd  $runningPath_4/bin
./mule stop
#Unpack a clear mule kernel file
echo `date '+%Y%m%d:%H%M%S'` ": ****************** Unpacking a clear mule kernel file"
cd $renewLicensePath
unzip mule-ee-distribution-standalone-4.1.5.zip -d $renewLicensePath/tmp/
#Run/Stop the fresh distribution to generate the new trial license
echo `date '+%Y%m%d:%H%M%S'` ": ****************** Running/Stopping the fresh distribution to generate the new trial license"
cd $renewLicensePath/tmp/mule-enterprise-standalone-4.1.5/bin
./mule start
sleep 60  # wait 60 secs to start the fresh distribution
./mule stop
#sleep 60 # wait 60 secs to full stopping
#Save the old license and set the new one
echo `date '+%Y%m%d:%H%M%S'` ": ****************** Saving the old license and set the new"
mv $runningPath_4/conf/muleLicenseKey.lic $renewLicensePath/tmp/muleLicenseKey.lic_`date '+%Y%m%d:%H%M%S'`
cp $renewLicensePath/tmp/mule-enterprise-standalone-4.1.5/conf/muleLicenseKey.lic $runningPath_4/conf/
#Delete the fresh distribution
cd $renewLicensePath/tmp/
rm -fr mule-enterprise-standalone-4.1.5
#Star the service
echo `date '+%Y%m%d:%H%M%S'` ": ****************** Starting the productive service"
cd $runningPath_4/bin
./mule -verifyLicense
./mule start
echo `date '+%Y%m%d:%H%M%S'` ": ################### END RENEW LICENSE OF 4.X KERNEL VERSION ######################"



