#! /bin/bash
VSCODIUMBRANCH=$VSCODIUMBRANCH
echo "running entrypoint.sh..."
echo "*** using cora-vscodium branch: $VSCODIUMBRANCH ***"

firstRun(){
	git clone https://github.com/belanglos/cora-vscodium.git ~/workspace/cora-vscodium
	if [ $VSCODIUMBRANCH != 'master' ]; then
		echo "*** checking out cora-vscodium branch: $VSCODIUMBRANCH ***"
		cd ~/workspace/cora-vscodium
		git checkout $VSCODIUMBRANCH
		cd ~
	fi

	echo "Installing VSCodium";
	installVSCodium();
		
	chmod +x ~/workspace/cora-vscodium/development/setupProjects.sh
	~/workspace/cora-vscodium/development/setupProjects.sh ~/workspace
	
	cd ~/workspace/cora-react-ts-test/
	npm cache clean --force
	#npm install
    
}

installVSCodium(){
	echo "Installing VSCodium...";
	wget -O - https://github.com/VSCodium/vscodium/releases/download/1.61.2/VSCodium-linux-x64-1.61.2.tar.gz | tar zxf - -C ~/vscodium/vscodiumforcora
}

if [ ! -d ~/workspace/cora-jsclient ]; then
  	firstRun
elif [ ! -d ~/vscodium/vscodiumforcora ]; then
	runInstaller
else
	# ~/vscodium/vscodiumforcora/vscodium
    echo "END!"
fi