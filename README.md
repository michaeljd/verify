# Ownership Verification
## Glossary
`source`: Email address, mobile phone number, etc.
`code`: Verification code generated by verification service

## Flow
1. App requests confirmation of a particular `source`.
2. Verification system generates `code`
3. Verification system sends `code` in verification email/sms/etc.
4. Verification encrypts and returns `code` + `source`
5. App requests user input `code` that was sent to `source`
6. User enters code into app input, form submitted with `source`, `code`, and JWE
7. Verification system compares `source` and `code` submitted by form with
   `source` and `code` inside the JWE.

## Actions
Request verification
 * Generate security `code` (simple string, i.e. 4 digit number)
 * Send email, sms, etc. containing `code` to `source`
 * Build JWE from a `source` (email, phone) with the `code`
 * Return JWE

Confirm verification
 * Check JWE `source` + `code` VS payload `source` + `code`
 * Return signed JWT with `source` (for external systems)
