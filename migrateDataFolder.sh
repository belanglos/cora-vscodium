#!/bin/bash

PREVIOUSFOLDERNAME=$1
TARGET=./vscodium/vscodiumforcora/

if [ ! $PREVIOUSFOLDERNAME ]; then
  	echo "You must specify the folder name of the previous installation of VSCodiumForCora, e.g. vscodium1_61_2forcora3"
else
    echo Copying files from $PREVIOUSFOLDERNAME to $TARGET
    cp -r ../$PREVIOUSFOLDERNAME/vscodium/vscodiumforcora/data $TARGET
fi
