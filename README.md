# To get started

- Create a folder which will contain the installations of cora-vscodium, e.g. `mkdir parentDir`
- `cd parentDir`
- Clone this repo, e.g. `git clone https://github.com/belanglos/cora-vscodium/`
- Make the main install script executable `chmod +x ./cora-vscodium/runAll.sh`


# First installation:
- After the steps above
- cd into the parentDir
- Have your dockerId ready, to get it run `getent group docker`
- run `./cora-vscodium/runAll.sh <your-docker-id> true`, replace `<your-docker-id>` with your docker id.
- When VSCodium starts for the first time, just close it and let the install continue, the startup is needed to create the correct folder structure
- When the installation is done you should see the following files/directories:

```
parentDir
|- cora-vscodium/
|- vscodium1_62_3forcora3/
|- env.sh
|- startCurrentVSCodiumForCora.sh
```

- To start, run `startCurrentVSCodiumForCora.sh` from your parentDir.
- Go through the "setup" steps in VSCodium
- "Open Folder" `workspace/cora-react-client`
- If asked and if you want to, confirm that you trust the authors, check the checkbox if you plan to only clone repos into workspace that you trust

# NPM scripts

The scripts that you will probably need the most are:
- `npm start` starts the development server at http://localhost:33001/
- `npm test` runs (and watches) the tests
- `npm run coverage` runs coverage and opens report in firefox 

# To be able to push to Github

into your parentFolder, put a .gitconfig file with content:

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
