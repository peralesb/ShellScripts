#!/bin/bash

CPU_LOAD_LASTMINUTE=$(uptime | cut -d"," -f4 | cut -d":" -f2 | cut -d" " -f2 | sed -e "s/\.//g")
CORES=`cat /proc/cpuinfo | awk '/^processor/{print $3}' | wc -l`
CPU_THRESHOLD=90

if [ $CPU_LOAD_LASTMINUTE -gt $(( CPU_THRESHOLD*CORES )) ] ; then
        echo `date`: LOAD CPU: $(( $CPU_LOAD_LASTMINUTE/CORES ))%, THRESHOLD: $(( CPU_THRESHOLD ))%
   echo `date`: High CPU use at the last minute!!, the Mule ESB will be restarted...
   echo `date`: Statistics: uptime
   echo `date`: Creating Dumps...
   echo `date`: Process IDs:
   sudo jps | grep Mule | cut -d ' ' -f 1
   for i in `sudo jps | grep Mule | cut -d ' ' -f 1`
   	do
		sudo jstack -l $i > /home/ubuntu/Mule_`echo $i`_`date +%Y%m%d_%H%M%S`.tdump
	done
   echo `date`: Dumps createds ok
   echo `date`: Restarting mule-enterprise-standalone-4.2.1-hf1 and mule-enterprise-standalone-4.3.0-hf1 ESB
   sudo /home/ubuntu/mule-enterprise-standalone-4.2.1-hf1/bin/mule restart
   sudo /home/ubuntu/mule-enterprise-standalone-4.3.0-hf1/bin/mule restart
   echo `date`: Restart completed
 else
         echo `date`: The last minute is not with high CPU consumption: $(( CPU_LOAD_LASTMINUTE/CORES ))% vs THRESHOLD $(( CPU_THRESHOLD ))%.
 fi

exit 0
