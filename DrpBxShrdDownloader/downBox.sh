#!/bin/sh

dropBoxSharedFolder=$1

filenameRegEx="(/)(([[:alnum:]\_]|%[[:alnum:]]{2})*(\.pdf|.PDF))"

for link in $(curl -s $1 | grep "<a href" | grep -oE '(https?:\/\/)([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/([[:alnum:]\_\-]+\/)*([[:alnum:]\_]|%[[:alnum:]]{2})*(\.pdf|.PDF)' | uniq); do 
	[[ $link =~ $filenameRegEx ]]
	filename=${BASH_REMATCH[2]}
	filename="${filename//\%/\\x}"
	filename=`echo -e $filename`
	curl -L $link?dl=1 -o "$filename" 
done

