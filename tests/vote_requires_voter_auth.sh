#!/usr/bin/env bash

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"; source "${ROOT}/library.sh"

boot $0

action_ok propose proposer1@active \
'{"proposer":"proposer1", "proposal_name":"votrqauth2", "title":"A simple one", "proposal_json":null}'

action_ko vote voter1@active \
'{"voter":"voter2","proposer":"proposer1","proposal_name":"votrqauth2","proposal_hash":"","vote":0,"vote_json":""}' \
'missing authority of voter2'
