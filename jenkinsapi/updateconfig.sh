#!/bin/bash

. env.sh

currentpromt=$(pwd)
updatepath=$(echo $currentpromt/Update)

filenames=($(ls -A1 $updatepath))


for index in ${!filenames[*]}
do
    filename=${filenames[${index}]/.xml/}
    curl --silent --write-out "Update ${filename} - HTTP: %{http_code}\n" -X POST --header "Content-Type: application/xml" --data @Update/${filename}.xml "${jenkinshost}/job/${filename}/config.xml" --user ${apikey}
done