# Action - `{{ expire }}`

## Description

`expire` can only be called by {{ proposer }}.

`expire` is used to modify the value of `expires_at` to the new time {{ expires_at }}. Once `expire` has been called,
no more votes will be accepted for {{ proposal_name }}.
