#!/usr/bin/env bash

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"; source "${ROOT}/library.sh"

boot $0

action_ok propose proposer1@active \
'{"proposer":"proposer1", "proposal_name":"propwork1", "title":"A simple one", "proposal_json":null}'

table_row proposal proposer1 "propwork1"
