#!/bin/bash

# Get database(s) specified in parameters
DATABASES="${@}"

# Default value to ${DATABASE} if no parameters is given
if [[ -z ${DATABASES} ]]
then
        # Get existing databases and exclude default databases
        DATABASES=$(echo "SHOW DATABASES WHERE \`Database\` NOT IN ('mysql', 'performance_schema', 'sys', 'information_schema');" | mysql);
fi

databaseExist() {
	EXISTING_DATABASE=$(echo "SHOW DATABASES LIKE '${DATABASE}';" | mysql);
        if [[ -z ${EXISTING_DATABASE} ]]
        then
        	echo "The specified database : ${DATABASE} doesn't exist.";
		return 1; # false
	fi
}

dump() {
	mkdir -p /tmp/save;
        DUMP="/tmp/save/dump-${DATABASE}-$(date +\%Y\%m\%d).sql";
        mysqldump ${DATABASE} > ${DUMP};
        echo "Dump of ${DATABASE} done. Dump file path : ${DUMP}";
}

main() {
	# Make a dump for all databases
	for DATABASE in ${DATABASES}; do
	        if [ ${DATABASE} != "Database" ]
	        then
	                if databaseExist;
	                then
	                	dump ${DATABASE};
	                fi
	        fi
	done
}

main ${DATABASES};
