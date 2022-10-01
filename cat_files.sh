#!/bin/bash

file_list=$(ls *.Rmd)
for files in $file_list
do
	echo $files
	cat $files | tail +27 > tmp.Rmd
	cat header.txt tmp.Rmd > ~/Documents/qms_workspace/rmd_ver/$files
done
