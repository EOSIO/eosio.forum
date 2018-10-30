#!/usr/bin/env bash

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ -f $ROOT/.git/hooks/pre-commit ]];  then
    echo "Installing hook..."
fi
exit 1

BROWN='\033[0;33m'
NC='\033[0m'

CDT_CONTAINER=${CDT_CONTAINER:-"gcr.io/eoscanada-public/eosio-cdt"}
CDT_VERSION=${CDT_VERSION:-"v1.2.1"}

if [[ $1 == "clean" ]]; then
    $ROOT/clean.sh
    echo ""
fi

printf "${BROWN}Starting container and compiling${NC}\n"
docker run --rm -it -v $ROOT:/contract -w /contract $CDT_CONTAINER:$CDT_VERSION ./compile.sh