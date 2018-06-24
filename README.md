A simple forum, messaging and voting system for EOS
===================================================

This forum stores nothing on chain, but only allows authenticated
messages to go through.  Off-chain tools are needed to External tools are needed to

Use case #1 - Simple chat
-------------------------

Allow anyone to send messages authenticated with their account
credentials through the blockchain. Simple and effective authenticated
chat, with support for threads and replies to individual messages.

This makes it very similar to Twitter: broadcast style, with
conventions to be built or imported from other traditions (hashtags
anyone?). With the `json_metadata` field, applications are free to
create filters, and conventions that make sense for them.


Use case #2 - Referendum
------------------------

With a well publicized upcoming referendum, Block Producers could ask
the token holders to cast a vote on a given proposition.

They could create a Google Doc with contents, have it translated, and
assign it a single URL. This file could state the different
`vote_value`s available (ex: `"yes"` and `"no"`).  All users would
need to do is:

```
cleos push action eosio.forum vote `{"voter": "myvoteracct", "proposition": "https://googdocs.example.com/path/to/proposition/123512345", "vote_value": "yes"}`
```

or the equivalent on any wallet or web UI.

All that information would be public, and a few tools to read the
blockchain could be easily created, just like when upon Launch, many
teams created tools to validate the blockchain, in different
languages, with an agreed conception of what we validated.

Therefore, when BPs trust the results of the referendum, they can take
action, having proofs of an honest tally and honest representation of
the token holder community.



Use case #3 - Block Producers alerts
------------------------------------

By following the changes to the producer schedule, one can listen only
on Block Producers accounts to see if any messages of a given type are
sent.

Instrumentation would then be easy to trigger alerts. Example:

1. Define some `json_metadata` like this: `{"type": "alert_bps"}` or simply a string like `wake-up-bps` to be put in `content`.
2. All BPs could have systems to watch the blockchain for such messages
3. When 3 BPs in the top 21 sent this message, it could buzz their phone and they could gather in some agreed-upon place.
4. Many levels of messages could exist, and could change during history.


Use case #4 - ECAF Orders
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



LICENSE
-------

MIT


Credits
-------

Original code and inspiration: Daniel Larimer
