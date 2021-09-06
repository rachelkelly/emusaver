#!/bin/bash

# a tool to send emulation save kits (a term I am making up) up to AWS S3
# if using this just for FF5, the only var needing definition is the complete linux-style 
# path to the windows location.  /mnt/c/snesstuff/EMUPROJ/ is just mine.

# usage: workon emusave
#        ./gamesender.sh send
#        OR
#        ./gamesender.sh get

computerdate=$(date +%s)
humandate=$(date +%F)
game="ff5"
sendbundle="$game-$humandate-epoch$computerdate.tar.gz"
location="/mnt/c/snesstuff/EMUPROJ"
bucket="s3://emusaves"

# tarballs & sends bundle
send() {
    echo $(date)
    echo "Sending data to S3 ..." && sleep 2
    if [[ -e $location/current ]]; then
        cd $location/current && tar -czvf $sendbundle -X $HOME/emusaver/exclude.txt .
    else cd $location && tar -czvf $sendbundle -X $HOME/emusaver/exclude.txt .
        fi
    tar tvf $sendbundle
    aws s3 cp $sendbundle $bucket/

    # each user can maintain their own snes9x.conf.  it changes with ~imperceptible things,
    # so it is safer to take it out of consideration.
    # in addition to being moved around with send/get, it's also in the .gitignore.
    cp $location/current/snes9x.conf $HOME/emusaver/
    cd $HOME
}

# first, we secure the bundle that might be local
# looks for newest object in bucket based on its S3-applied timestamp - NOT the date on the label
get() {
    echo $(date)
    echo "Receiving data from S3 ..." && sleep 2
    if [[ -e $location/current ]]; then
        assurance
        rm -rf $location/current/
    fi

    mkdir -p $location/current
    newest=$(aws s3 ls $bucket | sort | tail -n 1 | awk '{print $4}')
    aws s3 cp $bucket/$newest $location/current
    cd $location/current && tar -xzvf $newest

    # after the tarball is resettled, we place the user's specific snes9x.conf for their use
    cp $HOME/emusaver/snes9x.conf $location/current/
}

assurance() {
    if [[ -e $location/backup ]]; then
        rm -rf $location/backup
    fi
    mkdir -p $location/current
    mkdir -p $location/backup
    mv $location/current/* $location/backup/
    echo "Current batch backed up getting new"
}

last_one() {
    latest=$location/current/*.tar.gz
    echo $latest
}

# janky argsv, just for you 😘
if [[ $1 == "send" ]]; then
    send
elif [[ $1 == "get" ]]; then
    get
elif [[ $1 == "latest" ]]; then
    last_one
fi


