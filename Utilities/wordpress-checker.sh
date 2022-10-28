#!/bin/bash

# bash SCRIPTNAME [OPTION]... [ARGUMENTS]...

OPTION="${1}";
PARAMETERS="${@}";

# -----------
#  CONSTANTS
# -----------

OPTION_URL=0;
OPTION_DOMAIN=0;

# -----------
#  VARIABLES
# -----------

urls=""
domains=""

# -----------
#  FUNCTIONS
# -----------

function onlyOptionalParameters() {
	throwError() { echo "You pass an argument [ ${param} ] incompatible with the selected option [ ${1} ]."; }
	regex='';
	echo ${1};
	if [ ${1} == "--url" ];
	then
		regex='^(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]\.[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]$';
	fi
	echo ${regex};
	for param in ${PARAMETERS}; do
		echo $param;
		if [ $param =~ $regex ];
    then
    	throwError
    fi
  done
}

function sortParameters() {
	echo -e "No option given, we are sorting your parameters. Please wait...";
	sleep 1;
}

# ---------
#  STARTER
# ---------

if [[ -z ${PARAMETERS} ]];
then
	echo "You need to pass data (domain or url) in parameter.";
	exit;
fi

case $OPTION in
	-u | --url)
		onlyOptionalParameters --url;
		OPTION_URL=1;
    ;;
	-d | --domain)
		onlyOptionalParameters --domain;
    OPTION_DOMAIN=1;
    ;;
  *)
    sortParameters;
    exit;
    ;;
esac
