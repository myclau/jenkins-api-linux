#!/bin/bash
. env.sh

viewname='Container Technology'

currentpromt=$(pwd)
downloadpath=$(echo $currentpromt/Download)
jobNames=($(curl -X GET "${jenkinshost}/view/${viewname/ /%20}/config.xml"  --user ${apikey} \
| grep '<string>' \
| sed -E "s/<string>(.*)<\/string>/\1/g"))

[ ! -d $downloadpath ] && mkdir $downloadpath

for jobname in ${jobNames[*]}
do
    jobfilename="${jobname/ /%20}"
    curl --silent --write-out "Download ${jobfilename}.xml - HTTP: %{http_code}\n"  -X GET "${jenkinshost}/job/${jobfilename}/config.xml" --user ${apikey} -o $downloadpath/${jobfilename}.temp.xml
    cat $downloadpath/${jobfilename}.temp.xml | xml fo --quiet > $downloadpath/${jobfilename}.xml
    rm -f $downloadpath/${jobfilename}.temp.xml
done