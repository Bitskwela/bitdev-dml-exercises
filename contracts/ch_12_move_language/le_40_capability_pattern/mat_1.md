````markdown
# Mat 1: Capability Pattern

## Scene

Ronnie stared at the access control logic sprawled across his screen. Nested if-statements checked roles, verified addresses, and validated permissions—a tangled mess that had grown with every new feature.

"Odessa, I need your eyes on this," he called out. "The admin system is becoming a nightmare. Every function has its own permission checks, and they're all slightly different."

Odessa walked over and scrolled through the code. "I see the problem. You're checking _who_ has permission every time. But Move gives us a better option—checking _what_ permission they have."

"What's the difference?"

"Instead of verifying addresses everywhere, you give authorized users a capability token. The token itself is the proof of permission." She sketched a diagram. "If someone has a `MinterCap`, they can mint. If they have an `AdminCap`, they can administrate. The function just requires the capability—no address lookups."

Ronnie's eyes widened. "So the capability is like a key card? You either have it or you don't."

"Exactly. And because capabilities are resources in Move, they can't be copied or faked. You can transfer them, store them, even split them—but you can't forge them."

"What about revoking access?"

Odessa smiled. "That's where it gets elegant. The capability holder stores their token as a resource. To revoke access, you simply remove or destroy the capability. No blacklists, no role tables to update."

Ronnie nodded slowly. "Permission as a resource. The type system enforces access control."

---

## Topics

### 1. What is the Capability Pattern?

The Capability Pattern represents permissions as transferable resource tokens. Holding the capability grants the permission:

```move
module examples::cap_intro {
    use std::signer;

    /// Capability to mint tokens - whoever holds this can mint
    struct MintCapability has store {}

    /// Capability to burn tokens
    struct BurnCapability has store {}

    /// Only callable if you have MintCapability
    public fun mint(cap: &MintCapability, amount: u64): u64 {
        // cap reference proves permission
        amount
    }

    /// Only callable if you have BurnCapability
    public fun burn(cap: &BurnCapability, amount: u64) {
        // Burn logic here
    }
}
```

The presence of `&MintCapability` in the function signature is the access control. No address checks needed.

### 2. Storing and Managing Capabilities

Capabilities are typically stored as resources in the holder's account:

```move
module examples::cap_storage {
    use std::signer;

    struct AdminCapability has key, store {}

    struct Treasury has key {
        balance: u64
    }

    /// Grant admin capability to an address
    public fun grant_admin(granter: &signer, recipient: &signer) acquires AdminCapability {
        // Verify granter is the module owner
        assert!(signer::address_of(granter) == @examples, 1);

        // Give recipient the admin capability
        move_to(recipient, AdminCapability {});
    }

    /// Admin-only function - requires stored capability
    public fun withdraw(admin: &signer, amount: u64): u64 acquires AdminCapability, Treasury {
        // Verify caller has AdminCapability
        assert!(exists<AdminCapability>(signer::address_of(admin)), 2);

        let treasury = borrow_global_mut<Treasury>(@examples);
        treasury.balance = treasury.balance - amount;
        amount
    }

    /// Revoke by removing the capability
    public fun revoke_admin(admin: &signer) acquires AdminCapability {
        let AdminCapability {} = move_from<AdminCapability>(signer::address_of(admin));
    }
}
```

### 3. Granular Permissions

Capabilities can encode specific permission levels:

```move
module examples::granular_caps {
    /// Read-only capability
    struct ReadCap has store {}

    /// Write capability (implies read)
    struct WriteCap has store {
        read_cap: ReadCap
    }

    /// Full admin capability
    struct AdminCap has store {
        write_cap: WriteCap
    }

    struct Document has key {
        content: vector<u8>
    }

    /// Anyone with ReadCap can read
    public fun read(cap: &ReadCap, doc: &Document): vector<u8> {
        doc.content
    }

    /// WriteCap holders can modify
    public fun write(cap: &WriteCap, doc: &mut Document, content: vector<u8>) {
        doc.content = content;
    }

    /// Extract read capability from write capability
    public fun get_read_cap(cap: &WriteCap): &ReadCap {
        &cap.read_cap
    }
}
```

### 4. Delegating Capabilities

Capabilities can be passed, borrowed, or delegated:

```move
module examples::delegation {
    use std::signer;

    struct TransferCap has key, store {
        max_amount: u64
    }

    /// Create a delegated capability with limits
    public fun delegate(
        cap: &TransferCap,
        recipient: &signer,
        max_amount: u64
    ) {
        // Delegated cap cannot exceed original
        assert!(max_amount <= cap.max_amount, 1);

        move_to(recipient, TransferCap { max_amount });
    }

    /// Use capability to transfer (consumes some limit)
    public fun transfer(cap: &mut TransferCap, amount: u64) {
        assert!(amount <= cap.max_amount, 2);
        cap.max_amount = cap.max_amount - amount;
        // Execute transfer...
    }
}
```

---

## Closing Scene

Ronnie pushed the refactored code. The sprawling permission checks had been replaced with clean capability requirements. Each privileged function simply demanded the appropriate capability type.

"Let's test the new admin flow," Odessa suggested.

Ronnie granted himself an `AdminCap`, called the protected function successfully, then revoked the capability. The next call failed immediately.

"No role tables, no address lists," Ronnie said appreciatively. "The capability is the permission."

Odessa nodded. "And when you need to delegate access, you just pass or copy the capability. When you need to revoke, you destroy it. The type system handles the rest."

"Access control as resource management," Ronnie mused. "Why didn't I think of this before?"

---

## Summary

- The Capability Pattern represents permissions as resource tokens
- Holding a capability grants the associated permission—no address checks needed
- Capabilities have `store` ability to be held in accounts or other structs
- Granting permission means giving someone a capability resource
- Revoking permission means removing or destroying the capability
- Capabilities can encode hierarchical or granular permission levels
- Delegation is natural—just pass or store the capability
````
