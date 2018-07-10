A simple forum, messaging and voting system for EOS
===================================================

This forum stores nothing in the in-RAM blockchain state. It allows authenticated
messages to go through, where they are visible in the transaction history of the chain.
Off-chain tools are needed to sort, display, aggregate and report on the outputs
of the various calls supported by the Forum contract.




Referendum structure proposals
==============================

`propose` a question to be voted with those parameters (`proposal_json` version #1)

```
proposer: eosio
proposal_name: thequestion
title: "EOSIO Referendum: The Question About ECAF and friends"  # An English string, to be shown in UIs
proposal_json: '{
  "type": "bp-proposal-v1",
  "content": "# Tally method\n\nThe tally method will be this and that, ... to the best of the active Block Producers's ability.\n\n# Voting period\n\nThe vote will stretch from the block it is submitted, and last for 1 million blocks.\n\n# Vote meaning\n\nA `vote` with value `true` means you adhere to the proposition.  A `vote` with value `false` means you do not adhere to the proposition.\n\n# The question\n\nDo you wish ECAF to become Santa Claus ?"
}'
```

The `vote` would look like:

```
voter: myaccount
proposer: eosio
proposal_name: thequestion
proposal_hash: acbdef112387abcefe123817238716acbdef12378912739812739acbd  # sha256 of "title + proposal_json" of proposal
vote: true
vote_json: ''
```

---

`proposal_json` structure #2:

```
proposal_json: '{
  "type": "bp-proposal-v1",
  "tally": "The tally method will be this and that, ... to the best of the active Block Producers's ability.",
  "voting_period": "The vote will stretch from the block it is submitted, and last for 1 million blocks.",
  "vote_meaning": "A `vote` with value `true` means you adhere to the proposition.  A `vote` with value `false` means you do not adhere to the proposition.",
  "question": "Do you wish ECAF to become Santa Claus ?"
}'
```

---

`proposal_json` structure #3:

```
proposal_json: '{
  "type": "bp-proposal-v1",
  "tally": "The tally method will be this and that, ... to the best of the active Block Producers's ability.",
  "voting_period": "The vote will stretch from the block it is submitted, and last for 1 million blocks.",
  "vote_meaning": "A `vote` with value `true` means you adhere to the proposition.  A `vote` with value `false` means you do not adhere to the proposition.",
  "question": {
    "en": "Do you wish ECAF to become Santa Claus ?",
    "fr": "Voulez-vous que l'ECAF devienne le père Noël ?"
  }
}'
```



Current rollout
===============

The latest version is not yet published.  A previous version lives on
mainnet in the `eosforumtest` account.

Tools that integrated support for the `eosio.forum`:
* [eosc](https://github.com/eoscanada/eosc) has a client
  implementation to submit posts and votes (in unreleased `master`).
* https://eostoolkit.io/forumpost allows you to post content through
  `eosio.forum`.
* MyEOSKit already has special casing for the `post` actions. See
  [this transaction for example](https://www.myeoskit.com/?#/tx/c40e30d70ee92a0f57af475a828917851aa62b01bfbf395efae5c1a2b22068f0).


Actions
=======

See the available operations in the ABI file.

On a testnte with `eosio.forum` loaded, you can post with:

```
cleos push action eosio.forum post '{"poster": "YOURACCOUNT", "post_uuid":"somerandomstring", "content": "hello world", "reply_to_poster": "", "reply_to_post_uuid": "", "certify": false, "json_metadata": "{\"type\": \"chat\"}"}' -p YOURACCOUNT@active
```

and vote with:

```
cleos push action eosio.forum vote '{"voter": "YOURACCOUNT", "proposer": "proposer", "proposal_name": "theproposal", "vote": true, "vote_json": ""}' -p YOURACCOUNT@active
```

Use cases
=========

Use case #1 - Simple chat
-------------------------

Allow anyone to send messages authenticated with their account
credentials through the blockchain. Simple and effective authenticated
chat, with support for threads and replies to individual messages.

This makes it very similar to Twitter: broadcast style, with
conventions to be built or imported from other traditions (hashtags
anyone?). With the `json_metadata` field, applications are free to
create filters, and conventions that make sense for them.


Use case #2 - Voting
--------------------

Votes can be cast with the `vote` action. Say we are on a Zoom call,
we want a quick vote from the BP accounts' authority, we can say in
the zoom call: cast your vote with "go-no-go" as the proposal, or a
given Google Doc ref, and use "yes" or "no" as the `vote_value`.

We need very little tooling to do that, looking at 21 accounts that
are currently in `eosio.prods`, and counting the results.

This should allow for very quick decision making.


Use case #3 - Referendum
------------------------

With a well publicized upcoming referendum, Block Producers could ask
the token holders to cast a vote on a given proposition.

They could create a document as Markdown, have it translated, publish
it to IPFS.

This file could state the different `vote_value`s available (ex:
`"yes"` and `"no"`).  It could state the conditions or algorithm of
the tally, as well as a voting period in terms of block heights. For
community wide referendums, we can use the `proposition_hash` and
tools would hash the content of the proposition and put it there, so
no content changes are possible (IPFS guarantees that too).

All that users would need to do is:

```
cleos push action eosio.forum vote `{"voter": "myvoteracct", "proposition": "/ipfs/Qm123123123123123123123123", "proposition_hash": "abcdef123123123123123123123213", "vote_value": "yes"}`
```

or the equivalent on any wallet or web UI.

All that information would be public, and a few tools to read the
blockchain could be easily created, just like when upon Launch, many
teams created tools to validate the blockchain, in different
languages, with an agreed conception of what we validated.

Therefore, when BPs trust the results of the referendum, they can take
action, having proofs of an honest tally and honest representation of
the token holder community.



Use case #4 - Block Producers alerts
------------------------------------

By following the changes to the producer schedule, one can listen only
on Block Producers accounts to see if any messages of a given type are
sent.

Instrumentation would then be easy to trigger alerts. Example:

1. Define some `json_metadata` like this: `{"type": "alert_bps"}` or simply a string like `wake-up-bps` to be put in `content`.
2. All BPs could have systems to watch the blockchain for such messages
3. When 3 BPs in the top 21 sent this message, it could buzz their phone and they could gather in some agreed-upon place.
4. Many levels of messages could exist, and could change during history.


Use case #5 - ECAF Orders
-------------------------

ECAF-related (or other Arbitration forums) accounts could be watched
for messages of a given type, and BPs could get an alert on their
phones when certain messages arrive. This would be especially useful
for orders that need quick actions (like account freeze).

We could define some `json_metadata` with the accounts, keys and/or
contracts to be frozen, along with refs to documents showing proofs
and whatever docs is required to convince the BP to take the proposed
action.  Some metadata could also be a proposed `eosio.msig`
transaction, added by the Arbiters, ready to be reviewed and signed;
like a `transfer`, a `code` update or whatever is the order.

Having the data on-chain would mean we can easily instrument our
systems, to quickly review and apply such orders.


Use case #6 - Identity validation
---------------------------------

Ask someone offline to send a given message, like "pickles and
friends".  If they do send that message with an EOS account, you know
you're talking to someone who has access to the BP account's `post`
action.



Security
========

The `vote` and `post` actions, especially for BP accounts, would
ideally be shielded by a custom permission with `updateauth` (`cleos
set account permission`) and `linkauth` (`cleos set action
permission`).

See https://github.com/eoscanada/eos-claimer setup for an example.




LICENSE
=======

MIT


Credits
=======

Original code and inspiration: Daniel Larimer
