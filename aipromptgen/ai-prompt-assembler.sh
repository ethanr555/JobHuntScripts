#!/bin/bash

prompt=promptheader.txt
inputjs=indeedjdrip.js

if [[ $1 == "indeed" ]]; then
	inputjs=indeedjdrip.js
elif [[ $1 == "linkedin" ]]; then
	inputjs=linkedinjdrip.js
fi

js=$(cat $inputjs | grep -v "var prompt")
output="var prompt = "\'$(cat $prompt)\'\;$js

# Tests if xclip is installed on machine, otherwise exit 1.
command -v xclip &> /dev/null
if [[ $? ]]; then
	echo $output | xclip
	echo $output | xclip -selection clipboard
else
	echo xclip is not installed on this computer. Please install it with "apt install xclip" and then rerun the script.
	exit 1
fi
