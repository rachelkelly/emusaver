#!/bin/bash

# a tool to send emulation save kits (a term I am making up) up to AWS S3
# if using this just for FF5, the only var needing definition is the complete linux-style 
# path to the windows location.  /mnt/c/snes stuff/EMUPROJ/ is just mine.

# usage: ./gamesender.sh send
#        ./gamesender.sh get

computerdate=$(date +%s)
humandate=$(date +%F)
game="ff5"
sendbundle="$game-$humandate-epoch$computerdate.tar.gz"
location="/mnt/c/snesstuff/EMUPROJ/"
bucket="s3://emusaver/"

# janky argsv, just for you 😘
if [[ $1 == "send" ]]; then
    send
elif [[ $1 == "get" ]]; then
    get
fi

# tarballs & sends bundle
send() {
    tar -czvf $sendbundle $location
    tar tvf $sendbundle
    aws s3 cp $sendbundle $bucket
}

# first, we secure the bundle that might be local
# looks for newest object in bucket based on its timestamp (not the date on the label)
get() {
    assurance
    newest=$(aws s3 ls s3://emusaves | sort | tail -n 1 | awk '{print $4}')
    aws s3 cp $bucket/$newest $location
    cd $location && tar -xzvf $newest
}

assurance() {
    mkdir -p $location/{backup,current}
    mv $location/current/* $location/backup/
    echo "Current batch backed up before sending"
}


