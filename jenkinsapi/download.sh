#!/bin/bash
. env.sh

viewname='<any name>'

currentpromt=$(pwd)
downloadpath=$(echo $currentpromt/Download)
jobNames=($(curl -X GET "${jenkinshost}/view/${viewname/ /%20}/config.xml"  --user ${apikey} \
| grep '<string>' \
| sed -E "s/<string>(.*)<\/string>/\1/g"))

[ ! -d $downloadpath ] && mkdir $downloadpath

for jobname in ${jobNames[*]}
do
    curl --silent --write-out "Download ${jobname/ /%20}.xml - HTTP: %{http_code}\n"  -X GET "${jenkinshost}/job/${jobname/ /%20}/config.xml" --user ${apikey} -o $downloadpath/${jobname/ /%20}.xml
done
