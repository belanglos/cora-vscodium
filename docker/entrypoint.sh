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

	echo "Installing VSCodium"
	installVSCodium
		
	chmod +x ~/workspace/cora-vscodium/development/setupProjects.sh
	~/workspace/cora-vscodium/development/setupProjects.sh ~/workspace
	
	cd ~/workspace/cora-react-ts-test/
	npm cache clean --force
	#npm install
    
}

installVSCodium(){
	echo "Installing VSCodium...";
	mkdir ~/vscodium/vscodiumforcora
	wget -O - https://github.com/VSCodium/vscodium/releases/download/1.61.2/VSCodium-linux-x64-1.61.2.tar.gz | tar zxf - -C ~/vscodium/vscodiumforcora

	mkdir ~/vscodium/vscodiumforcora/data

	echo "Starting VSCodium for the first time to create folder structure in data."
	~/vscodium/vscodiumforcora/codium

	mv ~/data/settings.json ~/vscodium/vscodiumforcora/data/user-data/User

	rm -rf ~/data

	installExtensions

	#dbaeumer.vscode-eslint-2.1.20
	#esbenp.prettier-vscode-9.0.0
}

installExtensions(){
	wget -O /tmp/vscode-eslint.vsix https://github.com/microsoft/vscode-eslint/releases/download/insider%2F2.1.20/vscode-eslint-2.1.20.vsix
	unzip -d /tmp/vscode-eslint /tmp/vscode-eslint.vsix
	mv /tmp/vscode-eslint/extension ~/vscodium/vscodiumforcora/data/extensions/dbaeumer.vscode-eslint-2.1.20

	wget -O /tmp/prettier-vscode.vsix https://github.com/prettier/prettier-vscode/releases/download/v9.0.0/prettier-vscode-9.0.0.vsix
	unzip -d /tmp/prettier-vscode /tmp/prettier-vscode.vsix
	mv /tmp/prettier-vscode/extension ~/vscodium/vscodiumforcora/data/extensions/esbenp.prettier-vscode-9.0.0
}

if [ ! -d ~/workspace/cora-jsclient ]; then
  	firstRun
elif [ ! -d ~/vscodium/vscodiumforcora ]; then
	runInstaller
else
	# ~/vscodium/vscodiumforcora/vscodium
    echo "END!"
fi