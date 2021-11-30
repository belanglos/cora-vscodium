chmod +x runAll.sh

Recommended folder structure:
```
parentFolder/
|- cora-vscodium/
|- 
``` 

`cora-vscodium/runAll.sh <your-dockerid> master nocache <recommendedSetup>`


# First installation:

`./cora-vscodium/runAll.sh <your-docker-id> master nocache true`

- When VSCodium starts for the first time, close it, the startup is needed to create the correct folder structure
- When you're asked to choose remote, choose 6


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
