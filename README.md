# Stealth-address-starknet
Deployed Addresses:


When Alice wants to send money to bob, she can send it directly to him for the public network to identify both of them.
Sending assets, especially ERC20 tokens as payments in a public network is a inherant property of ethereum, however some cases cases are tricky, 
1) when the sender/receiver doesn't want to be doxxed with their POAPs
2) A vendor wants to sell to both B2B customers without them knowing each other.
3) Private Messaging
4) Multisigatures where the decision has to be taken independent of bias etc.

In such cases, A user might not be best incentivised to send payments on the public network.

a 
A stealth Address can solve this with unlinkability between Alice and bob by 
1) Bob generates his root spending key (m) and stealth meta-address (M).
2) Bob adds an ENS record to register M as the stealth meta-address for bob.eth.
3) We assume Alice knows that Bob is bob.eth. Alice looks up his stealth meta-address M on ENS.
4) Alice generates an ephemeral key that only she knows, and that she only uses once (to generate this specific stealth address).
5) Alice uses an algorithm that combines her ephemeral key and Bob's meta-address to generate a stealth address. She can now send assets to this address.
6) Alice also generates her ephemeral public key, and publishes it to the ephemeral public key registry (this can be done in the same transaction as the first transaction sending assets to this stealth address).
7) For Bob to discover stealth addresses belonging to him, Bob needs to scan the ephemeral public key registry for the entire list of ephemeral public keys published by anyone for any reason since the last time he did the scan.
8) For each ephemeral public key, Bob attempts to combine it with his root spending key to generate a stealth address, and checks if there are any assets in that address. If there are, Bob computes the spending key for that address and remembers it.

The generation of the stealth address is as follows
1) Bob generates a key m, and computes M = G * m, where G is a commonly-agreed generator point for the elliptic curve. The stealth meta-address is an encoding of M.
2) Alice generates an ephemeral key r, and publishes the ephemeral public key R = G * r.
3) Alice can compute a shared secret S = M * r, and Bob can compute the same shared secret S = m * R.
In general, in both Bitcoin and Ethereum (including correctly-designed ERC-4337 accounts), an address is a hash containing the public key used to verify transactions from that address. So you can compute the address if you compute the public key. To compute the public key, Alice or Bob can compute P = M + G * hash(S)
4) To compute the private key for that address, Bob (and Bob alone) can compute p = m + hash(S)

Stealth address although can receive the tokens, have the limitation of unable to be transferred if they are not the native gas token.
So, we use Account abstraction ERC 4337 to pay for the transfers done from the stealth addresses.


###Limitation
NFTs are unique and can be linked. ERC20's payments make the best use case out of steal address generation

###To do:
Steal Address Contract with Registry, A account abstraction module to sponsor gas for the stealth address.
- function to generates a stealth meta-address and emits it(input B, secp256k1 code) called by Alice, output (public and private: view and spend keys)
- function to send payment to the stealth address called by Alice. Create an announcement.
- Account abstraction sponsors gas upon any received transaction
- Bob parses , how?
- function to generate private key for stealth address called by B after parsing(input b)
- function to withdraw to Bob

###challenge:
learning ECC, cairo for the first time. Utils to ECC can't be found.

