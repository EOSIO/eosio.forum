#!/usr/bin/env bash

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"; source "${ROOT}/library.sh"

## Add few more proposals/votes for easier development purposes

### Proposals

action_ok propose proposer1@active \
"{\"proposer\":\"proposer1\", \"proposal_name\":\"a1\", \"title\":\"A simple one\", \"proposal_json\":null, \"expires_at\":\"${EXPIRES_AT}\"}"

action_ok propose proposer1@active \
"{\"proposer\":\"proposer1\", \"proposal_name\":\"z1\", \"title\":\"A simple one\", \"proposal_json\":null, \"expires_at\":\"${EXPIRES_AT}\"}"

action_ok propose proposer1@active \
"{\"proposer\":\"proposer1\", \"proposal_name\":\"51\", \"title\":\"A simple one\", \"proposal_json\":null, \"expires_at\":\"${EXPIRES_AT}\"}"

action_ok propose proposer1@active \
"{\"proposer\":\"proposer1\", \"proposal_name\":\"1a\", \"title\":\"A simple one\", \"proposal_json\":null, \"expires_at\":\"${EXPIRES_AT}\"}"

action_ok propose proposer1@active \
"{\"proposer\":\"proposer1\", \"proposal_name\":\"1z\", \"title\":\"A simple one\", \"proposal_json\":null, \"expires_at\":\"${EXPIRES_AT}\"}"

action_ok propose proposer1@active \
"{\"proposer\":\"proposer1\", \"proposal_name\":\"11\", \"title\":\"A simple one\", \"proposal_json\":null, \"expires_at\":\"${EXPIRES_AT}\"}"

action_ok propose proposer1@active \
"{\"proposer\":\"proposer1\", \"proposal_name\":\"zzzzzzzzzzzz\", \"title\":\"A simple one\", \"proposal_json\":null, \"expires_at\":\"${EXPIRES_AT}\"}"

### Votes

#### Voter1

action_ok vote voter1@active \
"{\"voter\":\"voter1\",\"proposal_name\":\"a1\",\"vote\":0,\"vote_json\":\"\"}"

action_ok vote voter1@active \
"{\"voter\":\"voter1\",\"proposal_name\":\"z1\",\"vote\":1,\"vote_json\":\"\"}"

action_ok vote voter1@active \
"{\"voter\":\"voter1\",\"proposal_name\":\"51\",\"vote\":1,\"vote_json\":\"\"}"

action_ok vote voter1@active \
"{\"voter\":\"voter1\",\"proposal_name\":\"1z\",\"vote\":1,\"vote_json\":\"\"}"

#### Voter2

action_ok vote voter2@active \
"{\"voter\":\"voter2\",\"proposal_name\":\"a1\",\"vote\":0,\"vote_json\":\"\"}"

action_ok vote voter2@active \
"{\"voter\":\"voter2\",\"proposal_name\":\"z1\",\"vote\":1,\"vote_json\":\"\"}"

action_ok vote voter2@active \
"{\"voter\":\"voter2\",\"proposal_name\":\"51\",\"vote\":1,\"vote_json\":\"\"}"

action_ok vote voter2@active \
"{\"voter\":\"voter2\",\"proposal_name\":\"1a\",\"vote\":1,\"vote_json\":\"\"}"

action_ok vote voter2@active \
"{\"voter\":\"voter2\",\"proposal_name\":\"11\",\"vote\":1,\"vote_json\":\"\"}"

#### zzzzzzzzzzzz (Voter)

action_ok vote zzzzzzzzzzzz@active \
"{\"voter\":\"zzzzzzzzzzzz\",\"proposal_name\":\"a1\",\"vote\":1,\"vote_json\":\"\"}"

action_ok vote zzzzzzzzzzzz@active \
"{\"voter\":\"zzzzzzzzzzzz\",\"proposal_name\":\"z1\",\"vote\":1,\"vote_json\":\"\"}"
