#!/bin/bash

#Create template file in case output file is bad
tempfile=.tempresumefile
touch $tempfile

#Handles exit gracefully by cleaning up extra files
function HandleExit () {
	rm -f $tempfile
	return $1
}

job1item1=""
job1item2=""
job1item3=""
job1item4=""
job2item1=""
job2item2=""
job2item3=""
job2item4=""
force=1 #Whether to force output file overwriting

while [[ $# -gt 0 ]]; do
	case $1 in
		-i|--input)
			export inputfile=$2
			shift
			shift
			;;
		-f|--file)
			export varfile=$2
			shift
			shift
			;;
		-o|--output)
			export resultfile=$2
			shift
			shift
			;;
		-F|--force)
			force=0
			shift
			;;
		*)
			if [[ $varfile -eq "" ]]; then
				export job1item1=$1
				export job1item2=$2
				export job1item3=$3
				export job1item4=$4
				export job2item1=$5
				export job2item2=$6
				export job2item3=$7
				export job2item4=$8
			fi
			break
			;;
			
	esac
done

if [[ $inputfile == "" ]]; then
	echo "Specify input file with -i or --input"
	exit $(HandleExit 1)
fi

if [[ $resultfile == "" ]]; then
	echo "Specify output file with -o or --output"
	exit $(HandleExit 1)
elif [[ $resultfile == $tempfile ]]; then
	echo "Please use a different output file name, anything but $resultfile"
	exit $(HandleExit 1)
elif [[ -f $resultfile && $force -eq 1 ]]; then
	echo "$resultfile already exists!"
	exit $(HandleExit 1)
fi

if [[ $varfile != "" ]]; then
	source $varfile
fi

touch $resultfile
cat $inputfile > $tempfile

sed -i "$(echo s/\${job1item1}/"$job1item1"/)" $tempfile
sed -i "$(echo s/\${job1item2}/"$job1item2"/)" $tempfile
sed -i "$(echo s/\${job1item3}/"$job1item3"/)" $tempfile
sed -i "$(echo s/\${job1item4}/"$job1item4"/)" $tempfile
sed -i "$(echo s/\${job2item1}/"$job2item1"/)" $tempfile
sed -i "$(echo s/\${job2item2}/"$job2item2"/)" $tempfile
sed -i "$(echo s/\${job2item3}/"$job2item3"/)" $tempfile
sed -i "$(echo s/\${job2item4}/"$job2item4"/)" $tempfile

cp $tempfile $resultfile

exit $(HandleExit 0)
