#! /bin/bash

echo "Running setupDirectoriesAndScriptsForVSCodiumForCora..."

#USER=$1
SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname $SCRIPT)
PARENTDIR="$(dirname "$BASEDIR")"
INSTALLVERSION=vscodium1_62_3forcora3
INSTALLDIR=$PARENTDIR/$INSTALLVERSION
TOPDIR="$(dirname "$PARENTDIR")"

echo 
echo script: $SCRIPT
echo basedir: $BASEDIR
echo parentdir: $PARENTDIR
echo installdir: $INSTALLDIR

createDirectories(){
  	mkdir $INSTALLDIR
 	mkdir $INSTALLDIR/vscodium
  	mkdir $INSTALLDIR/workspace
 	mkdir $PARENTDIR/m2
}
	
changeAndCopyScripts(){
	cp $BASEDIR/startVSCodiumForCora.sh $INSTALLDIR/
	sed -i "s|INSTALLDIR|$INSTALLDIR|g" $INSTALLDIR/startVSCodiumForCora.sh
	sed -i "s|PARENTDIR|$PARENTDIR|g" $INSTALLDIR/startVSCodiumForCora.sh

	cp $BASEDIR/startVSCodiumForCoraTempSetup.sh $INSTALLDIR/
	sed -i "s|INSTALLDIR|$INSTALLDIR|g" $INSTALLDIR/startVSCodiumForCoraTempSetup.sh
	sed -i "s|PARENTDIR|$PARENTDIR|g" $INSTALLDIR/startVSCodiumForCoraTempSetup.sh

	cp $BASEDIR/migrateDataFolder.sh $INSTALLDIR/
	sed -i "s|INSTALLDIR|$INSTALLDIR|g" $INSTALLDIR/migrateDataFolder.sh
	sed -i "s|PARENTDIR|$PARENTDIR|g" $INSTALLDIR/migrateDataFolder.sh

	# cp $BASEDIR/startVSCodiumForCoraNoPorts.sh $INSTALLDIR/
	# sed -i "s|INSTALLDIR|$INSTALLDIR|g" $INSTALLDIR/startVSCodiumForCoraNoPorts.sh
	# sed -i "s|PARENTDIR|$PARENTDIR|g" $INSTALLDIR/startVSCodiumForCoraNoPorts.sh
	
	# cp $BASEDIR/development/projectListing.sh $INSTALLDIR/projectListing.sh
	# cp $BASEDIR/development/setupProjects.sh $INSTALLDIR/setupProjects.sh
	
	# cp $BASEDIR/docker/docker-compose.yml $INSTALLDIR/
	cp $BASEDIR/docker/Dockerfile $INSTALLDIR/
	cp $BASEDIR/docker/entrypoint.sh $INSTALLDIR/
	
	# cp $BASEDIR/docker/derived $INSTALLDIR/workspace/.derived
}

createGitConfigFile(){
	touch $PARENTDIR/.gitconfig
}

updateOrCreateEnv(){
	local PARENT="$1"
	local FILENAME=env.sh
	local FILE=${PARENT}${FILENAME}
	echo $FILE

	if [ ! -f "${FILE}" ]; then
			echo "$FILENAME does not exist in $PARENT"
			touch "${FILE}"
			echo "CURRENTVERSION=$INSTALLVERSION" > ${FILE}
	else
			echo "$FILE exists."
			. $FILE
			echo "Current version: $CURRENTVERSION, updating to $INSTALLVERSION"
			sed -i "s/${CURRENTVERSION}/${INSTALLVERSION}/g" $FILE
	fi
}

createStartScriptIfNotExists(){
    local PARENT="$1"
	local FILENAME=startCurrentVSCodiumForCora.sh
	local FILE=${PARENT}${FILENAME}

    if [ ! -f "${FILE}" ]; then
        echo "$FILENAME does not exist in $PARENT"
        cp $BASEDIR/$FILENAME $PARENT/
        chmod +x ${FILE}
	fi
}

setupStartScriptInParentFolder(){
	echo "Setting up start script in parent folder"
	updateOrCreateEnv $PARENTDIR
	createStartScriptIfNotExists $PARENTDIR

}

if [ ! -d $INSTALLDIR ]; then
	createDirectories
	changeAndCopyScripts
	createGitConfigFile
fi

setupStartScriptInParentFolder
