# Release monitoring and hotfix runbook

Assign named release, engineering, commerce and support owners before submission.
Record private contact details outside Git. During release, inspect store/TestFlight
crash diagnostics, user support, session reliability and RevenueCat/store reports.
Crashlytics is absent; zero analytics events cannot establish zero crashes.

| Signal | Action / evidence |
| --- | --- |
| Secret exposed, purchase without access, lost valid rights, blocked free game | Treat as critical immediately; record affected build/device and sanitized reproduction; stop further rollout where store controls permit; prepare hotfix and owner decision |
| Persistence failures / unsaved rounds increase | Compare absolute counts and users per build with baseline; reproduce retry/resume/upgrade; avoid deleting sessions |
| Purchase/restore failures | Reconcile SDK/store reports and product mapping; preserve valid cached and legacy rights; do not grant access from CTA events |
| Low activation/replay | Validate event delivery and denominators first; inspect observed host friction before product changes |

For every incident record UTC and local time, severity, owner, affected builds,
aggregate scope, evidence, mitigation, fix revision, validation and closure.
Do not attach snapshots, names, roles, words or raw SDK exceptions to diagnostics.

Preserve the released source commit/tag, catalog/mapping, lockfiles, config reference,
archive, dSYMs and signed IPA in restricted release storage. Do not commit keys,
credentials, participant data or IPA to Git. Pin source revision before building.

Hotfix: reproduce → minimal fix → focused regression and full required checks →
validate upgrade without uninstall plus privacy/restore on affected scenario →
new unique build → signed export/hash → TestFlight install → owner review →
separate authorization to submit/release. Record any schema change and recovery.
Never overwrite or erase legacy purchase mappings/session source to simplify a fix.
A Git revert cannot instantly roll back an installed store binary. Pausing rollout
does not remove already installed builds; store processing/review can delay recovery.
