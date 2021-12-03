#! /bin/bash

USER=$(id -u -n)
USERID=$(id -u)
DOCKERGROUPID=$1
RECOMMENDEDSETUP=${2:-false}
VSCODIUMBRANCH=${3:-'master'}
NOCACHE=$4

echo 
echo "running runAll.sh..."
echo running all using:
echo userName: $USER
echo userId: $USERID
echo dockerGroupId: $DOCKERGROUPID
echo recommended setup: $RECOMMENDEDSETUP
echo cora-vscodium branch: $VSCODIUMBRANCH


if [ ! $USER ]; then
  	echo you must specify the userName to be used when building vscodium1_62_3forcora3
elif [ ! $USERID ]; then
	echo you must specify the userid to be used when building vscodium1_62_3forcora3, use: id -u youruserid 
elif [ ! $DOCKERGROUPID ] && [ ! -d ./vscodiumForCora ]; then
	echo you must specify the dockergroupid to be used when building vscodium1_62_3forcora3, use: getent group docker 
else
	if [ ! -d ./vscodium1_62_3forcora3 ]; then
		./cora-vscodium/buildVSCodiumForCora.sh $USER $USERID $DOCKERGROUPID $NOCACHE
		./cora-vscodium/setupDirectoriesAndScriptsForVSCodiumForCora.sh
		# docker network create vscodiumForCoraNet
		# docker network create vscodiumForAlvinNet
		# docker network create vscodiumForDivaNet
	fi
#	./vscodiumForCora/startVSCodiumForCora.sh $USER
	./vscodium1_62_3forcora3/startVSCodiumForCoraTempSetup.sh $USER $VSCODIUMBRANCH $RECOMMENDEDSETUP
	echo "NOW ITS FINISHED!!"
fi