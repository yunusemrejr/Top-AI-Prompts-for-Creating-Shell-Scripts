# Verification & Quality Checklist for AI-Generated Shell Scripts

Before using any generated script in production or even staging:

- [ ] Shebang present and correct
- [ ] `set -euo pipefail` (or documented why not)
- [ ] All variables quoted
- [ ] Input validation + helpful error messages
- [ ] `--help` / usage function works
- [ ] Dry-run mode implemented and tested
- [ ] Logging to file + stdout (colors optional but nice)
- [ ] Error traps and cleanup functions
- [ ] No `eval` or dangerous patterns without strong justification
- [ ] Dependencies checked with `command -v`
- [ ] Idempotent where it makes sense (create user, install package, etc.)
- [ ] ShellCheck passes with 0 errors/warnings (or explained)
- [ ] Tested on target distro/kernel
- [ ] No hardcoded secrets or paths that break portability
- [ ] Comments explain *why*, not just *what*
- [ ] Handles interrupts (Ctrl+C) gracefully
- [ ] Exit codes meaningful (0 success, non-zero on failure)
- [ ] Documentation updated (README or header)

Run this checklist manually or prompt the LLM to self-review against it.