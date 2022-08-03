This repository contains a dockerized environment specifically tailored to be used for development of the DiVA React client and related repositories. The goal is that a developer should be able to follow the steps below and wind up with a working dev environment for diva-react-client.

# Usage

## Prerequisites

- Create a folder which will contain the installations of cora-vscodium, e.g. `mkdir parentDir`
- `cd parentDir`
- Clone this repo, e.g. `git clone https://github.com/lsu-ub-uu/cora-vscodium/`
- Make the main install script executable `chmod +x ./cora-vscodium/runAll.sh`


## First installation:
After the steps above
1. cd into the parentDir
2. Have your dockerId ready, to get it run `getent group docker`
3. run `./cora-vscodium/runAll.sh <your-docker-id> true`, replace `<your-docker-id>` with your docker id.
4. When VSCodium starts for the first time, just close it and let the install continue, the startup is needed to create the correct folder structure
5. When the installation is done you should see the following files/directories (ls -ahl):

```
parentDir
|- cora-vscodium/
|- env.sh
|- startCurrentVSCodiumForCora.sh
|- vscodium1_67_2forcora2/
```
#
1. To start, run `./startCurrentVSCodiumForCora.sh` from your parentDir.
2. Go through the "Get Started with VS Code" sections, or just choose your color theme and "Mark Done"
3. "Open Folder" `workspace/cora-react-client`
4. If asked "Do you trust the authors of the files in this folder?" you can confirm if you want, check the checkbox if you plan to only clone repos into workspace that you trust
5. Follow the steps in https://github.com/lsu-ub-uu/cora-react-client/ "To get started", skip step 1.


## Pushing to Github

into your parentDir, put a .gitconfig file with content:

```
[credential]
        helper = store
[user]
        name = yourname
        email = youremail
```

As well as a .git-credentials file with content:
``` 
https://[yourgithubusername]:[youraccesstoken]@github.com
```
        
The access token only has to have public_repo access.

Your parentDir should look like this now (ls -ahl):
```
parentDir
|- cora-vscodium/
|- vscodium1_67_2forcora2/
|- env.sh
|- .gitconfig
|- .git-credentials
|- startCurrentVSCodiumForCora.sh
```

## Updating to a newer version of cora-vscodium
1. cd into the directory cora-vscodium
2. run git pull to get the latest version - if there's nothing new, you can skip the next steps
3. cd into the parentDir
4. Have your dockerId ready, to get it run `getent group docker`
5. run `./cora-vscodium/runAll.sh <your-docker-id> false master nocache`, replace `<your-docker-id>` with your docker id.



# For maintainers of this repository

Keep an eye out for new versions of VSCodium or the extensions included in cora-vscodium. If there's an update to those, you should adapt the scripts in this repo to install the newer versions.
Below you'll find instructions on how to update different parts of cora-vscodium. If you've updated any of the parts, you should bump the versioning of cora-vscodium

## Bumping version
If you've done any change, make sure to bump the version of cora-vscodium. The easiest way to do this, is to find/replace the current version in all repo files with the new version. You can use your editors find/replace tool for that.
E.g. replace `vscodium1_67_2forcora2` with `vscodium1_69_2forcora1`.
At the time of writing, this results in 23 results in 7 files.


## VSCodium

1. Head to https://github.com/VSCodium/vscodium/releases and check the latest release
2. Compare it to the version specified in `docker/entrypoint.sh` (currently line 37)
3. If it's newer, copy the link to the correct tar.gz file and paste it into entrypoint.sh


## Extensions

Four extensions are automatically packaged within cora-vscodium. To update to a newer version, find the correct vsix or zip file on the extension's respective github page, and update the download link in `docker/entrypoint.sh
