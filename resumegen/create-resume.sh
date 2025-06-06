#!/bin/bash

# Determine resume template file to read in.
defaultoption() {
	if [[ -f $1 ]]; then
		echo $1
	else
		echo resume-default.tex
	fi
}

resumefile=resume-default.tex
jobname=""
jobcompany=""

# Read cmd arguments
while [[ $# -gt 0 ]]; do
	case $1 in
		-d)
		# Change resume template file read
			resumefile=$(defaultoption $2)
			shift
			shift
			;;
		*)
			jobname=$1
			jobcompany=$2
			shift
			shift
			;;
	esac
done

# Template file does not exist, end with exit 2
if [[ ! -f $resumefile ]]; then
	echo $resumefile does not exist! >&2
	exit 2
fi

if [[ ! -d generated-resumes ]]; then
	mkdir generated-resumes
fi

filename="${jobname}_${jobcompany}_$(date +%I%M%S_%m%d%y)"
touch generated-resumes/$filename.tex

#See if file was successfully able to be created.
if [[  $? -ne 0 ]]; then
	echo Invalid name for resume file. Double check job name and company name for invalid characters >&2
	exit 1
fi

cat $resumefile > generated-resumes/$filename.tex

editor generated-resumes/$filename.tex

pdflatex -halt-on-error -output-directory generated-resumes generated-resumes/$filename.tex &> /dev/null

if [  $? -ne 0 ]; then
	echo Resume PDF generation failed. Check error logs of pdflatex for more info >&2
	exit 3
fi
#Clean up generated helper LaTeX files.
rm generated-resumes/*.aux
rm generated-resumes/*.out

if [[ ! -d generated-resumes/log ]]; then
	mkdir generated-resumes/log
fi

mv generated-resumes/*.log generated-resumes/log/

if [ ! -d generated-resumes/out ]; then
	mkdir generated-resumes/out
fi

mv generated-resumes/$filename.pdf generated-resumes/out/

exit 0
