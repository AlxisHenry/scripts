#!/bin/bash

# source : https://stackoverflow.com/questions/238073/how-to-add-a-progress-bar-to-a-shell-script

progress-bar() {

	local duration=${1}

	already_done() {
		for ((done=0; done<$elapsed; done++));
			do printf "▇";
		done
	}

	remaining() {
		for ((remain=$elapsed; remain<$duration; remain++));
			do printf " ";
		done
	}

	percentage() {
		printf "| %s%%" $(( (($elapsed)*100)/($duration)*100/100 ));
	}

	clean_line() {
		printf "\r";
	}

	for (( elapsed=1; elapsed<=$duration; elapsed++ ));
		already_done; remaining; percentage
	        sleep 1
	        clean_line
	done

	clean_line

}

progress-bar 10;
