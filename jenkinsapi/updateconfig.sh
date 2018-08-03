#!/bin/bash

. env.sh

currentpromt=$(pwd)
updatepath=$(echo $currentpromt/Update)

filefullnames=($(find $updatepath))
filenames=($(ls -A1 $updatepath))


for index in ${!filenames[*]}
do
    filename=${filenames[${index}]/.xml/}
    filefullname=${filefullnames[${index}]}
    curl --silent --write-out "POST ${filename} - HTTP: %{http_code}\n" -X POST --header "Content-Type:text/xml" --data @Update/${filename}.xml "${jenkinshost}/job/${filename}/config.xml" --user ${apikey}
done