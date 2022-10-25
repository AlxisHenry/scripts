#!/bin/bash

# Check if the specified service is installed
# Call the script with service(s) in parameters
# bash ServiceIsInstalled.sh [services...]

SERVICES="${@}";

for SERVICE in $(echo ${SERVICES})
do
	# if [ -f /usr/bin/${SERVICE} ];
	# then
	#	echo "${SERVICE} is installed";
	# fi
done
