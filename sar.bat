#!/usr/bin/bash

read -p 'Enter keyword/s:' KW1
find ~/R/qms/ver/*.Rmd -type f | xargs grep --color -i $KW1 > /dev/stdout