# Action - `{{ clnproposal }}`

## Description

This action is used to clear the RAM being used to store all information related to 
{{ proposal_name }}. All associated votes must be cleared before {{ proposal_name }}
can be cleared from the RAM of {{ proposer }}.

This action can be called by any user, requiring no authorization.

This action can only be called 72 hours after {{ expires_at }} has been reached.
{{ expires_at }} is set at the moment that {{ proposal_name }} is created, and can
only be updated by {{ proposer }}. This will allow time to compute a tally of all
associated votes before it can be cleared.

The user who calls {{ clnproposal }} will pay the CPU and NET bandwidth required
to process the action. They will need to specify {{ max_count }} to ensure that the 
action can be processed within a single block's maximum allowable limits.
