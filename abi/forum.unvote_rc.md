# Action - `{{ unvote }}`

## Description

`unvote` allows a user to remove their vote of {{ vote_value }} they have previously
cast on {{ proposal_name }}. 

`unvote` will not function during the 72 hour period after 
{{ proposal_name }} has expired at {{ expires_at }}.

The RAM that was used to store the vote shall be freed-up immediately
after `unvote` has been called by {{ voter }}.