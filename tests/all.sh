#!/usr/bin/env bash

set -e

TEST_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "${TEST_DIR}/library.sh"

print_config

for var in `ls $TEST_DIR`; do
    if [[ $var == "all.sh" || $var == "data.sh" || $var == local_*.sh || $var == "library.sh" || $var == "boot.sh" ]]; then
        continue
    fi

    if [[ $var != *.sh ]]; then
        continue
    fi

    echo "Running $var"
    bash "${TEST_DIR}/$var"
    echo ""
done
