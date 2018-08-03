#!/bin/bash

. env.sh

currentpromt=$(pwd)
addpath=$(echo $currentpromt/Add)

filenames=($(ls -A1 $addpath))


for index in ${!filenames[*]}
do
    filenameOnly=${filenames[${index}]/.xml/}
    filename=${filenameOnly/ /%20}
    checkexist=$(curl --silent "${jenkinshost}/api/json?pretty=true" --user ${apikey}| grep "${jenkinshost}/job/${filename}/")
    [ -z "${checkexist}" ] && \
    curl --silent --write-out "Create ${filename} - HTTP: %{http_code}\n" -X POST --header "Content-Type: application/xml" --data @Add/${filename}.xml "${jenkinshost}/createItem?name=${filename}" --user ${apikey}

done

