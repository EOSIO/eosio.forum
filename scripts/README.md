## Scripts

### `voter_key`

A simple script to print out `voter_key` info in various formats.

Compile with:

```
g++ -o scripts/voter_key -Wc++11-extensions scripts/voter_key.cpp
```

Run with:

```
./scripts/voter_key proposalname voter

Proposal name 'proposalname' (dec 12531646810014983328, hex 0XADE95A60D199A4A0)
Voter 'voter' (dec 15938990597461770240, hex 0XDD32AB8000000000)
Voter key
 Big endian: 0xADE95A60D199A4A0DD32AB8000000000
 Little endian: !TODO
```
