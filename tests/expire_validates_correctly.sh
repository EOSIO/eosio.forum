#!/usr/bin/env bash

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"; source "${ROOT}/library.sh"

info "Not existing"

action_ko expire proposer1@active \
'{"proposal_name":"expvacor2"}' \
'proposal not found.'

println

info "Already expired"

action_ok propose proposer1@active \
"{\"proposer\":\"proposer1\", \"proposal_name\":\"expvacorae5\", \"title\":\"A simple one\", \"proposal_json\":null, \"expires_at\":\"${EXPIRES_AT}\"}"

action_ok expire proposer1@active \
'{"proposal_name":"expvacorae5"}'

action_ko expire proposer1@active \
'{"proposal_name":"expvacorae5"}' \
'proposal is already expired.'

println

info "Requires authoritory of proposer"

action_ok propose proposer2@active \
"{\"proposer\":\"proposer2\", \"proposal_name\":\"expvacorma5\", \"title\":\"A simple one\", \"proposal_json\":null, \"expires_at\":\"${EXPIRES_AT}\"}"

action_ko expire proposer1@active \
'{"proposal_name":"expvacorma5"}' \
'missing authority of proposer2'

println
