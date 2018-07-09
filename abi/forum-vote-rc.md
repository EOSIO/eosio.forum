# Action - `{{ vote }}`

## Description

The intent of the `{{ vote }}` action is to cast a vote for {{ proposer }}'s {{ proposal_name }}, as refered by the `proposals` table under the {{ proposer }} scope.

, referencing an off-chain proposition.  This proposition is a URL or a short name shared within a community calling for a vote.

I, {{ voter }} cast a vote with the value `{{ vote }}` with the interpretation given by the {{ proposal_name }} proposal, giving my assent, conscious of the impact of my vote.

`{{ proposal_hash }}` is a hash of the concatenated `title` and `proposal_json` fields, through SHA-256, encoded with lowercase hexadecimal characters, and is provided in accordance with the requirement of the proposal.
