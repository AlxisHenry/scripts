#!/bin/bash

# Usage: bash script.sh [domain] [domain] ...

DOMAINS="$@";
TLDS=(
  "com"
  "net"
  "fr"
  "eu"
  "store"
  "online"
)

if [[ -z ${DOMAINS} ]];
then
	echo "You need to specify domain(s) in parameters";
	exit;
elif [[ -z ${TLDS} ]];
then
	echo "No TLDS impleted in TLDS array";
	exit;
fi

function __whois() {
	echo $1;
}

for domain in ${DOMAINS};
do
	for tld in "${TLDS[@]}"
	do
	        __whois "${domain}.${tld}";
	done
done
