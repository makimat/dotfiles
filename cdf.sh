#!/bin/bash

function cdf() {
    THEFILE=$1
    echo "cd into directory of ${THEFILE}"
    # For linux, replace mdfind with find . -name 
    THECOUNTOFMATCHES=$(mdfind -name ${THEFILE} |wc -l)
    if [[ "$THECOUNTOFMATCHES" -gt 1 ]]
    then

        THECOUNTOFMATCHES=$(mdfind -name ${THEFILE} |grep -Eo "/[ /._A-Za-z0-9\-]+/" |sort |uniq |wc -l)
        if [[ "$THECOUNTOFMATCHES" -gt 1 ]]
        then
            echo "there are $THECOUNTOFMATCHES matches"
            mdfind -name ${THEFILE}
        else
            THEDIR=$(mdfind -name ${THEFILE} |head -1 |grep -Eo "/[ /._A-Za-z0-9\-]+/") 
            cd ${THEDIR}
        fi
    else
        THEDIR=$(mdfind -name ${THEFILE} |head -1 |grep -Eo "/[ /._A-Za-z0-9\-]+/") 
        cd ${THEDIR}
    fi 
}
