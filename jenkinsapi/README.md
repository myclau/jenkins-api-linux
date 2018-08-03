How to use
==========

cd into this first

env.sh
------
set up api key and jenkins host URL

download.sh
-----------
config the view name, and run it , it will download all config.xml from jenkins to ./Download with the job name

updateconfig.sh
---------------
you can just download it with download.sh and move to .\Update and modify it
after that run updateconfig.sh then will update those job which in that folder to the job with the xml file name

createjob.sh
------------
create job according to /Add folder with providing xml file the xml filename will be the job name. But will not add to any view