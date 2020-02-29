#!/bin/bash -x

REPOS=(
    "uniesiApi"
    "uniesiWeb"
    "uniesiDocker"
)
REPO=""
PATH_REPO=""
BASE_PATH=${PWD}

GetPathRepo() {
    cd ..
    PATH_REPO="$BASE_PATH/repo/$REPO"
    cd "$BASE_PATH" || exit
}

Clear() {
    rm -rf repo
}

Clone() {
    echo "==========================="
    echo "Clonando repositório $REPO"
    GetPathRepo
    rm -rf "$REPO.git"
    mkdir -p "$PATH_REPO"
    git clone --bare git@github.com:mckatoo/$REPO.git
    cd "$BASE_PATH/$REPO.git/hooks" || exit
    touch post-receive
    chmod +x post-receive
    echo "#!/bin/sh" >>post-receive
    echo "GIT_WORK_TREE=$PATH_REPO git checkout -f" >>post-receive
    export GIT_WORK_TREE=$PATH_REPO
    cd "$PATH_REPO" || exit
    git checkout -f
    cd "$BASE_PATH" || exit
}

Clear
for i in "${REPOS[@]}"; do
    REPO=$i
    Clone
done

exec docker-compose up -d
