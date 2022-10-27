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
	request=$(whois $1 |grep "NOT FOUND");
	if [[ ! -z $request ]];
	then
		echo "The domain ${1} is available !";
	else
		echo "The domain ${1} is already taken...";
	fi
}

for domain in ${DOMAINS};
do
	echo "Who is ${domain} :";
	for tld in "${TLDS[@]}"
	do
	        __whois "${domain}.${tld}";
	done
	echo "";
done
