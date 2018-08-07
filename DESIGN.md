Third iteration design
----------------------

Right now, we have tables like:

```
cleos get table eosforumdapp eoscanadacom proposal
```

code=eosforumdapp scope=eoscanadacom table=proposal

```
cleos get table eosforumdapp eosforumdapp status
```



New actions
-----------

`propose`
 // Assert the `proposal_name` isn't "status", NOR "proposal"... as to not confuse table names in the contract itself.

`vote` proposer, proposal_name, voter, vote, vote_json
    // Assert la proposition existe encore

`unvote` proposer, proposal_name, voter
   // Si la proposiion existe plus, tu peux quand même l'enlever


If a single table per proposer, we'd get something like:
```
code=eosforumdapp scope=eoscanadacom table=votes
```

We COULD use a secondary index, and create a new uint64.

CHECK with endianess of the lower/upper bound to search the secondary index.
```
 pk=proposal_name+voter proposal_name=allo vote=... vote_json...
 pk=proposal_name+voter proposal_name=allo
 pk=proposal_name+voter proposal_name=allo
 ```

We could delete rows by lower/upper proposal_name + name("").

OR:
---

One table per voters with NO Secondary index, only a primary key that
is the `voter`. Excludes the possibility of using the `"proposal"`
name as a `proposal_name`.

code=eosforumdapp scope=eoscanadacom table=[proposal_name]

  pk=voter (name)


`unpropose` proposer, proposal_name
  // Efface la proposition

`cleanvotes`
  proposer, proposal_name, count

  // Assert the proposeR+proposal_name doesn't exist anymore, or is expired.
  // Loop la table
  //
