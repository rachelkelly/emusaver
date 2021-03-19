#!/bin/bash

# a tool to send emulation save kits (a term I am making up) up to AWS S3

# get location of saves, bundle up entirety of save file

computerdate=$(date +%s)
humandate=$(date %F)
savebundle="ff5$humandate$epoch.tar.gz"

#tar -czvf $savebundle -X exclude.txt "/mnt/c/snes stuff/EMUPROJ/"
tar -czvf $savebundle "/mnt/c/snes stuff/EMUPROJ/"
tar tvf $savebundle
#aws s3 cp 
