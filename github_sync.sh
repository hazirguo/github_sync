#! /bin/bash

if [ $# != 1 ]; then
    echo -e "\nUSAGE: github_sync.sh conf_file\n"
    exit 1
fi

CONF_FILE="$1"

while read LINE
do
    project_name=`echo $LINE | cut -d ',' -f1`
    github_url=`echo $LINE | cut -d ',' -f2`
    cc_url=`echo $LINE | cut -d ',' -f3`
    if [ -d $project_name.git ]; then
        cd $project_name.git
        git fetch
        git push -u cc_origin
        cd ../
    else
        git clone --mirror $github_url $project_name.git
        cd $project_name.git
        git remote add cc_origin $cc_url
        cd ../
    fi
done < $CONF_FILE



