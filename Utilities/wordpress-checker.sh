#!/bin/bash

# bash SCRIPTNAME [OPTION]... [ARGUMENTS]...

OPTION="${1}";

if [ ${OPTION} == "--url" ];
then
	PARAMETERS="$(echo ${@} |cut -c 7-)";
else
	PARAMETERS="$(echo ${@} |cut -c 4-)";
fi

# -----------
#  CONSTANTS
# -----------

OPTION_URL=0;
# OPTION_DOMAIN=0;

# -----------
#  VARIABLES
# -----------

urls=""
# domains=""

# -----------
#  FUNCTIONS
# -----------

function throw() {
	echo $1;
}

function onlyOptionalParameters() {
	regex='';
	if [ ${1} == "--url" ];
	then
		regex='^(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]\.[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]$';
	fi
	for param in ${PARAMETERS}; do
		if [[ ! ${param} =~ ${regex} ]];
    then
    	throw "You passed an argument [ ${param} ] who's not corresponding to the selected option ${1}.";
    fi
  done
}

function sortParameters() {
	echo -e "No option given, we are sorting your parameters. Please wait...";
	sleep 1;
}

function request() {
	for param in ${PARAMETERS}; do
		response=$(curl -s ${param} |grep "wp-content");
		if [[ -z ${response} ]];
		then
			throw "Sorry, but nothing was found on this parameter: [ $param ].";
		else
			throw "We found some traces of Wordpress on the following url: [ $param ].";
		fi
	done
}

# ---------
#  STARTER
# ---------

if [[ -z ${PARAMETERS} ]];
then
	echo "You need to pass data (domain or url) in parameter.";
	exit;
fi

case ${OPTION} in
	-u | --url)
		onlyOptionalParameters --url;
		OPTION_URL=1;
		request --url ${PARAMETERS};
    ;;
	-d | --domain)
		#onlyOptionalParameters --domain;
    #OPTION_DOMAIN=1;
		exit;
    ;;
  *)
    #sortParameters;
		throw "Argument passed [ ${OPTION} ] is not valid.";
    exit;
    ;;
esac
