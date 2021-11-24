#! /bin/bash

USER=$(id -u -n)
USERID=$(id -u)
DOCKERGROUPID=$1
VSCODIUMBRANCH=$2
NOCACHE=$3
RECOMMENDEDSETUP=${4:-false}

if [ ! $VSCODIUMBRANCH ]; then
	VSCODIUMBRANCH='master'
fi

echo 
echo "running runAll.sh..."
echo running all using:
echo userName: $USER
echo userId: $USERID
echo dockerGroupId: $DOCKERGROUPID
echo cora-vscodium branch: $VSCODIUMBRANCH
echo recommended setup: $RECOMMENDEDSETUP


if [ ! $USER ]; then
  	echo you must specify the userName to be used when building vscodium1_62_3forcora1
elif [ ! $USERID ]; then
	echo you must specify the userid to be used when building vscodium1_62_3forcora1, use: id -u youruserid 
elif [ ! $DOCKERGROUPID ] && [ ! -d ./vscodiumForCora ]; then
	echo you must specify the dockergroupid to be used when building vscodium1_62_3forcora1, use: getent group docker 
else
	if [ ! -d ./vscodium1_62_3forcora1 ]; then
		./cora-vscodium/buildVSCodiumForCora.sh $USER $USERID $DOCKERGROUPID $NOCACHE
		./cora-vscodium/setupDirectoriesAndScriptsForVSCodiumForCora.sh
		# docker network create vscodiumForCoraNet
		# docker network create vscodiumForAlvinNet
		# docker network create vscodiumForDivaNet
	fi
#	./vscodiumForCora/startVSCodiumForCora.sh $USER
	./vscodium1_62_3forcora1/startVSCodiumForCoraTempSetup.sh $USER $VSCODIUMBRANCH $RECOMMENDEDSETUP
fi