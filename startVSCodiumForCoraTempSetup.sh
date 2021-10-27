#! /bin/bash

#USER=$1
USER=$(id -u -n)
BASEDIR=$(dirname $BASH_SOURCE)
VSCODIUMBRANCH=$2

echo 
echo "running startEclipseForCoraTempSetup.sh..."
echo starting vscodium using:
echo userName: $USER
echo cora-vscodium branch: $VSCODIUMBRANCH
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
  	echo "You must specify the userName used when starting vscodium1_61_2forcora3TempSetup"
else
cd vscodium1_61_2forcora3
#${CONTAINERRUNTIME} run --rm -ti --privileged --net=host --ipc=host --env="QT_X11_NO_MITSHM=1"  -e DISPLAY=$DISPLAY \
${CONTAINERRUNTIME} run --rm -ti --privileged --ipc=host --env="QT_X11_NO_MITSHM=1"  -e DISPLAY=$DISPLAY \
 -v /var/run/docker.sock:/var/run/docker.sock\
 -v /tmp/.X11-unix:/tmp/.X11-unix\
 -v INSTALLDIR/workspace:/home/$USER/workspace\
 -v INSTALLDIR/vscodium:/home/$USER/vscodium\
 -v PARENTDIR/m2:/home/$USER/.m2\
 -e user=$USER\
 -e vscodiumbranch=$VSCODIUMBRANCH\
 --name vscodium1_61_2forcora3TempSetup\
 vscodium1_61_2forcora3
 cd ../
fi
