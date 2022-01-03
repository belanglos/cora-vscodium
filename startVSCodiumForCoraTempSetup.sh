#! /bin/bash

#USER=$1
USER=$(id -u -n)
BASEDIR=$(dirname $BASH_SOURCE)
VSCODIUMBRANCH=$2
RECOMMENDEDSETUP=$3

echo 
echo "running startEclipseForCoraTempSetup.sh..."
echo starting vscodium using:
echo userName: $USER
echo cora-vscodium branch: $VSCODIUMBRANCH
echo recommended setup: $RECOMMENDEDSETUP
echo 
echo "Testing for container runtimes...."
CONTAINERRUNTIME=podman;
DOCKER_EXISTS=$(command -v docker)
echo "Docker size: "${#DOCKER_EXISTS}
if [ ${#DOCKER_EXISTS} -gt 0 ]; then
	CONTAINERRUNTIME=docker;
fi
echo "Container runtime will be "${CONTAINERRUNTIME}

if [ ! $USER ]; then
  	echo "You must specify the userName used when starting vscodium1_62_3forcora5TempSetup"
else
cd vscodium1_62_3forcora5
#${CONTAINERRUNTIME} run --rm -ti --privileged --net=host --ipc=host --env="QT_X11_NO_MITSHM=1"  -e DISPLAY=$DISPLAY \
${CONTAINERRUNTIME} run --rm -ti --privileged --ipc=host --env="QT_X11_NO_MITSHM=1"  -e DISPLAY=$DISPLAY \
 -v /var/run/docker.sock:/var/run/docker.sock\
 -v /tmp/.X11-unix:/tmp/.X11-unix\
 -v INSTALLDIR/workspace:/home/$USER/workspace\
 -v INSTALLDIR/vscodium:/home/$USER/vscodium\
 -e user=$USER\
 -e vscodiumbranch=$VSCODIUMBRANCH\
 -e RECOMMENDEDSETUP=$RECOMMENDEDSETUP\
 --name vscodium1_62_3forcora5TempSetup\
 vscodium1_62_3forcora5
 cd ../
fi
