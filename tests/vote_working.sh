#!/usr/bin/env bash

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"; source "${ROOT}/library.sh"

boot $0

action_ok propose proposer1@active \
'{"proposer":"proposer1", "proposal_name":"votwork2", "title":"A simple one", "proposal_json":null}'

action_ok vote voter1@active \
'{"voter":"voter1","proposer":"proposer1","proposal_name":"votwork2","proposal_hash":"","vote":0,"vote_json":""}'

table_row vote proposer1 '"proposal_name": "votwork2", "voter": "voter1", "vote": 0, "vote_json": ""'
