# Replace all desired characters by the desired value

# Examples
# --------

# bash replace-character.sh [SUBJECT: string] [SEARCH: i] [REPLACE: a] [OPTIONS] : expected return "strang"
# bash replace-character.sh [SUBJECT: path] [SEARCH: i] [REPLACE: a] [OPTIONS: -file] : expected return void

# If you want to replace or search by multiple words, use quotes to write your sentence like "word word". For example :
# bash replace-character.sh [SUBJECT: path] [SEARCH "hi team"] [REPLACE: "hello, world !"] [OPTIONS: -file]

# Options
# -------

# -f / --file : Use a file instead of a string
# -d / --directory : Execute the script for all files in the directory
# -n / --no-save : Do not generate a temporary backup file

# Variables
# ---------

SUBJECT="$1";
SEARCH="$2";
REPLACE="$3";
OPTIONS="${@:4}";
PARAMETERS_COUNT=$#;
TEMP_BACKUP_FOLDER="/tmp/backup_before_replace";
BACKUP_PATH="";

# Options States
# --------------

SUBJECT_IS_FILE=0;
SUBJECT_IS_DIRECTORY=0;
GENERATE_BACKUP=1;

# Functions
# ---------

function checkArgumentsCount() {
        if [[ $PARAMETERS_COUNT < 3 ]];
        then
                echo "Too few arguments arguments, ${PARAMETERS_COUNT} passed in ${BASH_SOURCE} and exactly 3 expected.";
                exit;
        fi
}

function checkOptions() {
	for OPTION in ${OPTIONS}; do
	        if [ "${OPTION}" == "-f" -o "${OPTION}" == "--file" ];
	        then
			if [ ! -f ${SUBJECT} ];
			then
				echo "The file was not found... Try again with an existing path.";
				exit;
			fi
	                SUBJECT_IS_FILE=1;
	        elif [ "${OPTION}" == "-d" -o "${OPTION}" == "--directory" ];
	        then
			if [ ! -d ${SUBJECT} ];
			then
				echo "The specified path isn't a directory.";
				exit;
			fi
	                SUBJECT_IS_DIRECTORY=1;
	        elif [ "${OPTION}" == "-n" -o "${OPTION}" == "--no-save" ];
		then
			GENERATE_BACKUP=0;
		fi
	done
	if [ "${SUBJECT_IS_FILE}" == 1 -a "${SUBJECT_IS_DIRECTORY}" == 1 ];
	then
		echo "You cannot specify the following options at the same time : -f / --file, -d / --directory";
		exit;
	fi
}

function saveBeforeReplace() {
	if [ "${SUBJECT_IS_FILE}" == 1 -o "${SUBJECT_IS_DIRECTORY}" == 1 ];
	then
		if [ "${GENERATE_BACKUP}" == 0 ];
		then
			echo "You have chosen not to generate a backup file.";
		else
			SUBJECT_NAME=$(echo ${SUBJECT} |rev |cut -d "/" -f 1 |rev);
			BACKUP_PATH="${TEMP_BACKUP_FOLDER}/${SUBJECT_NAME}-$(date +'%m_%d_%Y_%H_%M_%S')";
			mkdir -p ${TEMP_BACKUP_FOLDER};
			if [ "${SUBJECT_IS_FILE}" == 1 ];
			then
				cp ${SUBJECT} ${BACKUP_PATH};
			elif [ "${SUBJECT_IS_DIRECTORY}" == 1 ];
			then
				cp -r ${SUBJECT} ${BACKUP_PATH};
			fi
			echo -e "\nBackup of ${SUBJECT} has been created at ${BACKUP_PATH}";
		fi
	fi
}

function revertChanges() {
	echo "";
}

function replace() {
        if [ "${SUBJECT_IS_FILE}" == 0 -a "${SUBJECT_IS_DIRECTORY}" == 0 ];
	then
		echo $(echo "${SUBJECT}" |sed -e "s/${SEARCH}/${REPLACE}/g");
	elif [ "${SUBJECT_IS_FILE}" == 1 ];
	then
		sed -i "s/${SEARCH}/${REPLACE}/g" ${SUBJECT};
		echo -e "\nThe file ${SUBJECT} was succesfully sed !\n";
	else
		echo -e "\nThis features isn't yet available.\n";
	fi
}

function doReplace() {
	checkArgumentsCount $PARAMETERS_COUNT;
	checkOptions;
	saveBeforeReplace;
	replace;
}

doReplace;
