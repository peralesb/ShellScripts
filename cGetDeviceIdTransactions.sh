
# USE: 
#
#	cGetDeviceIdTransactions.sh <deviceId> <date MM-DD>
#

for i in `cat logsMulesoft/mule-qtc* | grep "START FLOW" | grep "\"$1\"" | cut -d "|" -f 2`
do 
	cat logsMulesoft/mule-qtc* | grep $i | grep "$2"
done
