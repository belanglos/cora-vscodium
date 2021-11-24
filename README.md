chmod +x runAll.sh

cora-vscodium/runAll.sh dockerid master nocache recommendedSetup

e.g.

first installation:

./cora-vscodium/runAll.sh <your-docker-id> master nocache true


into your parent folder, put a .gitconfig file with content:

[credential]
        helper = store
[user]
        name = yourname
        email = youremail


As well as a .git-credentials file with content:

https://[yourgithubusername]:[youraccesstoken]@github.com

the access token only has to have public_repo access.