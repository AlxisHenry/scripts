#!/bin/bash

# Get current ram usage by service(s)
# Call the script with service(s) in parameters
# bash ram_usage.sh [services...]

PROCESS="${@}"

if [[ -z ${PROCESS} ]]
then
	echo "You need to give processus name(s) in parameters"
else
	for WORKER in $(echo ${PROCESS})
	do
		RAMUSAGE=$(ps -ely | awk -v process=${WORKER} '$13 == process' | awk '{SUM += $8/1024} END {print SUM}' | cut -d "." -f 1)
		if [[ -z $RAMUSAGE ]]
		then
			echo "No ram usage for ${WORKER}"
		else
			echo "Service: ${WORKER}, Ram usage: ${RAMUSAGE}"
		fi
	done
fi
