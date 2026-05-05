# Common Pitfalls in AI-Generated Shell Scripts & How to Avoid Them

## Top Pitfalls

1. **Missing or Incorrect Quoting**
   - Symptom: Word splitting, glob expansion, command injection risk.
   - Fix: Always include "quote all variables" in prompt. AI often forgets on complex lines.

2. **No or Weak Error Handling**
   - Symptom: Script continues after failure, partial state, hard to debug.
   - Fix: Mandate `set -euo pipefail` + `trap` + cleanup function.

3. **Hardcoded Values & Secrets**
   - Symptom: Breaks on different hosts, security risk.
   - Fix: Use env vars, config files, or CLI args. Never hardcode passwords.

4. **Ignoring Distro Differences**
   - Symptom: `apt` on RHEL, `systemctl` on SysVinit.
   - Fix: Make conditional or specify target in prompt.

5. **Overly Clever One-Liners**
   - Symptom: Unreadable, unmaintainable, fragile.
   - Fix: Prefer functions + comments. Readability > cleverness.

6. **Missing Dry-Run / Confirmation**
   - Symptom: Accidental data loss on first run.
   - Fix: Require `--dry-run` for any destructive operation.

7. **Deprecated or Non-Portable Commands**
   - Symptom: `ifconfig` instead of `ip`, old `netstat`.
   - Fix: Prompt for modern tools (`ip`, `ss`, `journalctl`).

8. **No Logging or Observability**
   - Symptom: Silent failures in cron/jobs.
   - Fix: Mandate structured logging + log file output.

## Prevention
Include the full "Full List of Prompting Best Practices" from the README in every prompt you use. This single habit eliminates 80%+ of issues.