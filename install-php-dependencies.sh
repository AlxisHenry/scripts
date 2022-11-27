dependencies="$@";

for dependence in ${dependencies};
do
	sudo apt install php-${dependence} -y;
done

