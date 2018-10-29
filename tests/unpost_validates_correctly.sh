#!/usr/bin/env bash

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"; source "${ROOT}/library.sh"

action_ko unpost poster2@active \
'{"poster":"poster1", "post_uuid":"1"}' \
'missing authority of poster1'

action_ko unpost poster1@active \
'{"poster":"poster1", "post_uuid":""}' \
'post_uuid should be longer than 0 characters.'

action_ko unpost poster1@active \
"{\"poster\":\"poster1\", \"post_uuid\":\"${CHARS_250}\"}" \
'post_uuid should be shorter than 128 characters.'
