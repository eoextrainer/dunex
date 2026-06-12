/**
 * DUNEX Partner Portal — Credential Store
 *
 * Passwords are stored as salted SHA-256 hashes (never plain text).
 * To rotate a password:
 *   1. Pick a new password.
 *   2. Run: node -e "const c=require('crypto');
 *             console.log(c.createHash('sha256').update('<salt><newpw>').digest('hex'));"
 *   3. Replace the sha256 value below.
 *
 * Salt format: "dnx-<initials>-2026"
 * Hash algo  : SHA-256(salt + password)  — verified client-side via Web Crypto API
 */
window.__DUNEX_CREDS = {
  v: 1,
  users: [
    {
      username: "maureen",
      displayName: "Maureen",
      role: "partner",
      tier: "Gold",
      salt: "dnx-mau-2026",
      sha256: "b2824761c76a4288a0785485f71b75649541581f8d11899f0ecfa7993414c74f"
    },
    {
      username: "darnell",
      displayName: "Darnell",
      role: "partner",
      tier: "Silver",
      salt: "dnx-dar-2026",
      sha256: "4f5fcbcdeb74f058dce20068de3d9db7a450e8dac3795ae86bfd23fa24bda876"
    },
    {
      username: "sosthene",
      displayName: "Sosth\u00e8ne",
      role: "admin",
      tier: "Platinum",
      salt: "dnx-sos-2026",
      sha256: "fe63d844d800fc71642988e8316f77c9ebecb3f6924c4445220e993cd86a3940"
    },
    {
      username: "aurelie",
      displayName: "Aur\u00e9lie",
      role: "partner",
      tier: "Bronze",
      salt: "dnx-aur-2026",
      sha256: "7c99ea23cb6ceed2e9b579519c10ba06e24bbb7131c5f1b661b094529b51393a"
    }
  ]
};
