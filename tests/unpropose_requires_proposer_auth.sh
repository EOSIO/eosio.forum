#!/usr/bin/env bash

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"; source "${ROOT}/library.sh"

boot $0

action_ko unpropose proposer1@active \
'{"proposer":"proposer2", "proposal_name":"unreqproau2"}' \
'missing authority of proposer2'
