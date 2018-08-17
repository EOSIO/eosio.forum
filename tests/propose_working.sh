#!/usr/bin/env bash

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"; source "${ROOT}/library.sh"

action_ok propose proposer1@active \
'{"proposer":"proposer1", "proposal_name":"propwork4", "title":"A simple one", "proposal_json":null}'

table_row proposal proposer1 '"proposal_name": "propwork4", "title": "A simple one", "proposal_json": ""'
