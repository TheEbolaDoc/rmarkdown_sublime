#!/bin/env bash

file_path=$1
file_name=$2
file_base_name=$3
file=$file_path'/'$file_name
file_type=$(cat $file | head -4 | grep pdf | cut -d ' ' -f2 | cut -d '_' -f1)
program=""

if [[ "$file_type" == "" ]]; then
    file_type="html"
fi

if [[ "$file_type" == "pdf" ]]; then
    program="evince"
fi

if [[ "$file_type" == "html" ]]; then
    program="firefox"
fi

echo $file_type
echo "require(rmarkdown); render ('$file') " | R --vanilla && exec $program $file_base_name.$file_type &> /dev/null &
