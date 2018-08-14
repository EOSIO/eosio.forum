#!/usr/bin/env bash

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"; source "${ROOT}/library.sh"

boot $0

action_ko propose proposer2@active \
'{"proposer":"proposer1", "proposal_name":"prpauth2", "title":"A simple one", "proposal_json":null}' \
'missing authority of proposer1'