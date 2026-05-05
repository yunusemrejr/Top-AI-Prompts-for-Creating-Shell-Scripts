# Verification & Quality Checklist for AI-Generated Shell Scripts — Expanded

## Why a Checklist Matters

Even excellent AI output benefits from a systematic final review. This checklist is designed to be used both by humans and as a prompt for the AI itself to self-review.

## Full Expanded Checklist (17+ items with explanations)

- [ ] Shebang present and correct for the target shell
- [ ] `set -euo pipefail` present (or documented reason why not)
- [ ] All variables properly quoted to prevent word splitting and injection
- [ ] Input validation for every argument with helpful error messages
- [ ] `--help` / usage function exists and is accurate
- [ ] Dry-run mode implemented and tested for all state-changing operations
- [ ] Logging implemented (stdout + file, optionally syslog)
- [ ] Error traps and cleanup functions present
- [ ] No dangerous patterns (`eval` on untrusted input, etc.)
- [ ] Dependencies checked with `command -v` and helpful install messages
- [ ] Idempotent where it makes sense (user creation, package install, config changes)
- [ ] ShellCheck passes (or warnings are understood and acceptable)
- [ ] Tested on target distro / kernel version
- [ ] No hardcoded secrets or non-portable absolute paths
- [ ] Comments explain *why* decisions were made (educational value)
- [ ] Handles interrupts (Ctrl+C / SIGINT) gracefully via traps
- [ ] Exit codes are meaningful and documented
- [ ] Documentation / README updated if this is a shared tool

## How to Use This Checklist with AI

After receiving a script, paste this checklist into a new prompt and ask the AI to review its own work against it and suggest improvements.