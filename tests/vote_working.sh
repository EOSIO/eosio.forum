#!/usr/bin/env bash

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"; source "${ROOT}/library.sh"

vote_json="{\\\\"a\\\\":\\\\"something\\\\"}"

action_ok propose proposer1@active \
"{\"proposer\":\"proposer1\", \"proposal_name\":\"votworka2\", \"title\":\"A simple one\", \"proposal_json\":null, \"expires_at\":\"${EXPIRES_AT}\"}"

action_ok vote voter1@active \
'{"voter":"voter1","proposal_name":"votworka2","vote":0,"vote_json":""}'

table_row vote ${CONTRACT} '"proposal_name": "votworka2", "voter": "voter1", "vote": 0, "vote_json": ""'

action_ok vote voter1@active \
"{\"voter\":\"voter1\",\"proposal_name\":\"votworka2\",\"vote\":1,\"vote_json\":\"${vote_json}\"}"

table_row vote ${CONTRACT} '!"proposal_name": "votworka2", "voter": "voter1", "vote": 0, "vote_json": ""'
table_row vote ${CONTRACT} '"proposal_name": "votworka2", "voter": "voter1", "vote": 1, "vote_json": "{\\a\\:\\something\\}"'
