# Action - `{{ propose }}`

## Description

`propose` creates a message on-chain with the intention of receiving 
votes from any community members who wish to cast a `vote`.

Each proposal shall be identified with a unique `proposal_name`.

An expiry will be defined in `expires_at`, with {{ expires_at }} 
being no later than 6 months in the future. 

{{ proposer }} must pay for the RAM to store {{ proposal_name }}, which
will be returned to them once `clnproposal` has been called.
