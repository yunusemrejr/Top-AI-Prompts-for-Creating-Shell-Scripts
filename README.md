# Top AI Prompts for Creating Shell Scripts

**A comprehensive, discoverable collection of high-quality prompts, examples, and best practices for using Large Language Models (LLMs) like Grok, Claude, GPT, and others to generate reliable, secure, efficient, and production-ready Linux shell scripts.**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Shell](https://img.shields.io/badge/Shell-Bash%20%7C%20POSIX-blue)](https://www.gnu.org/software/bash/)
[![AI](https://img.shields.io/badge/AI-LLM%20Prompts-purple)](https://github.com/yunusemrejr/Top-AI-Prompts-for-Creating-Shell-Scripts)

**Keywords / Topics for discoverability:** AI prompts, LLM shell scripts, bash scripting with AI, Linux automation prompts, best practices AI-generated scripts, prompting techniques for shell, kernel scripting, OS-specific automation, DevOps AI tools, shell script generation guide, idempotent scripts, secure bash, advanced bash examples.

## Table of Contents
- [Overview & Why Use AI for Shell Scripts](#overview--why-use-ai-for-shell-scripts)
- [Quick Start](#quick-start)
- [Full List of Prompting Best Practices & Considerations](#full-list-of-prompting-best-practices--considerations)
- [Detailed Prompting Techniques Guide](#detailed-prompting-techniques-guide)
- [Shell Techniques & How AI Benefits](#shell-techniques--how-ai-benefits)
- [How-to Guides & Verification](#how-to-guides--verification)
- [Common Pitfalls & Troubleshooting](#common-pitfalls--troubleshooting)
- [Example Scripts Library](#example-scripts-library)
- [Pure Prompt Templates](#pure-prompt-templates)
- [Contributing & Discoverability](#contributing--discoverability)

## Overview & Why Use AI for Shell Scripts

Large Language Models excel at generating boilerplate, complex logic, and variations of shell scripts quickly. However, **raw output often lacks robustness, security, error handling, and best practices**.

**Benefits of using this repo's approach:**
- Faster development of automation, DevOps, sysadmin tasks.
- Consistent quality with strict mode, validation, logging.
- Learn prompting patterns that produce production-grade code.
- Reduce bugs in critical infrastructure scripts.

**Limitations & AI Reality Check:** Always review, test in safe environment (dry-run first), use ShellCheck, and understand the generated code. AI can hallucinate commands or miss edge cases.

## Quick Start

1. Copy a prompt from `prompts/` or README.
2. Paste into your favorite LLM (Grok, Claude 3.5/4, GPT-4o, etc.).
3. Specify: target distro, strict mode, dry-run support, logging, help function.
4. Review output with ShellCheck.net.
5. Test with `--help` and dry-run mode.

Example prompt starter:
> "Write a robust bash script for [task]. Include shebang, set -euo pipefail, input validation, colored output, logging to file and syslog, dry-run flag, comprehensive comments, usage function, and error traps. Make it idempotent where possible. Target Ubuntu 22.04+."

## Full List of Prompting Best Practices & Considerations

When crafting prompts for LLMs to generate Linux shell scripts, **always include these specifications** for high-quality output:

1. **Shebang & Strict Mode**: Require `#!/usr/bin/env bash` + `set -euo pipefail` (or `set -e` for older).
2. **Error Handling**: `trap` for ERR/EXIT/INT, cleanup functions, proper exit codes.
3. **Argument Parsing**: `getopts`, `shift`, or `argparse`-style. Validate all inputs.
4. **Quoting & Safety**: Always quote variables (`"$var"`), avoid `eval` unless absolutely necessary with sanitization.
5. **Idempotency**: Scripts safe to run multiple times (check before create/modify).
6. **Dependencies**: `command -v` checks, install hints, version checks.
7. **Logging & Output**: Structured logs (JSON optional), colors (tput or ANSI), syslog via `logger`.
8. **Dry-Run / Simulation**: `--dry-run` or `-n` flag that prints actions without executing destructive ops.
9. **Help & Documentation**: Built-in `--help`, usage examples in comments/header.
10. **Portability**: Note bash 4+ features vs POSIX sh. Target specific distros or make conditional.
11. **Security**: No hardcoded secrets, input sanitization, least privilege (avoid sudo unless necessary + warn).
12. **Testing Hooks**: Suggest `shellcheck`, `bash -n`, unit tests with bats or shunit2.
13. **Performance**: For loops with `find -exec` or parallel, avoid unnecessary subshells.
14. **Destructive Safety**: Confirmation prompts or force flags for rm, dd, format, etc.
15. **Configuration**: Support env vars, config files, or CLI flags.
16. **Observability**: Metrics, status codes, structured output for parsing.

**Pro Tip for Prompts:** End every prompt with: "Follow all 16 best practices above. Add extensive comments explaining *why* each section exists."

## Detailed Prompting Techniques Guide

See the full guide in `docs/prompting-techniques.md`. Key advanced techniques:

- **Chain-of-Thought (CoT)**: "Think step by step: first check prerequisites, then validate args, then..."
- **Few-Shot Prompting**: Provide 1-2 small good examples in the prompt.
- **Role Prompting**: "You are an expert senior Linux sysadmin and bash scripting specialist with 15+ years experience in production environments."
- **Constraint Prompting**: List all constraints (strict mode, no eval, dry-run mandatory, etc.).
- **Iterative Refinement**: Start simple, then "Improve the previous script by adding X, Y, Z".
- **Output Format**: "Output only the complete script in a single markdown code block. No explanations outside."
- **Verification Loop**: After generation, prompt LLM again: "Review this script for security issues, missing error handling, and suggest improvements."

## Shell Techniques & How AI Benefits

See `docs/shell-techniques.md` for deep dive.

**Key Techniques AI Should Leverage:**
- **Arrays & Associative Arrays** (bash 4+): Better data handling than strings.
- **Functions & Local Vars**: Modularity, avoid global pollution.
- **Traps & Cleanup**: Reliable resource management (temp files, mounts).
- **Process Substitution** `<(cmd)` and coprocesses: Advanced piping without temp files.
- **Here Documents & Here Strings**: Clean multi-line input/output.
- **Parameter Expansion** `${var:-default}`, `${var//search/replace}`: Powerful string handling without external tools.
- **Job Control & Background**: `&`, `wait`, `disown` for parallel tasks.
- **Different Shells**: Bash (feature-rich), Zsh (completion, themes), Fish (user-friendly), POSIX sh (portability). Prompt AI to target specific shell.

**How AI Benefits from Knowing These:** LLMs that understand these produce more elegant, efficient, maintainable scripts instead of verbose or fragile code. They can suggest modern idioms over legacy patterns.

## How-to Guides & Verification

- Full how-to in `docs/how-to-use.md`
- Verification checklist in `docs/verification-checklist.md`
- Step-by-step: Generate → Review (ShellCheck) → Dry-run test → Staged rollout → Monitor logs.

## Common Pitfalls & Troubleshooting

See `docs/common-pitfalls.md`. Top issues:
- Missing quotes leading to word splitting.
- No error handling → silent failures.
- Hardcoded paths/secrets.
- Ignoring distro differences (apt vs dnf).
- Overly complex one-liners instead of readable functions.
- AI suggesting deprecated commands.

**Fix:** Always include the full best-practices list in your prompt.

## Example Scripts Library

All scripts in `/examples/` are production-oriented, heavily commented, and follow the best practices. They demonstrate real-world use cases for kernel, OS, security, monitoring, backup, networking, etc.

### Core Examples
- `system-info.sh` — Gather detailed system + kernel info.
- `backup.sh` — Timestamped, logged, with cleanup.
- `advanced-log-analyzer.sh` — journalctl + log files analysis.

### Advanced / Kernel / OS Specific
- `kernel-module-check.sh` — Loaded modules, sysctls, version-specific.
- `docker-monitor.sh` — Container + systemd service health.
- `secure-ssh-hardening.sh` — Automated SSH config with backup & restart.
- `firewall-manager.sh` (new) — ufw/firewalld abstraction.
- `performance-tuning.sh` (new) — sysctl, limits, I/O scheduler.
- `encrypted-backup.sh` (new) — GPG + rsync + verification.
- `user-provision.sh` (new) — Idempotent user/group management.
- `service-manager.sh` (new) — systemd service control with status.

Run any with `--help` for usage.

## Pure Prompt Templates

Ready-to-copy prompts in `/prompts/`. Examples:
- `prompt-backup.md`
- `prompt-security-audit.md`
- `prompt-kernel-debug.md`

## Contributing & Discoverability

See `CONTRIBUTING.md`. To improve discoverability:
- Star & fork the repo.
- Use keywords in issues/PRs: "AI prompt", "bash LLM", "shell script generation".
- Suggest new categories: networking, cloud (AWS/GCP/Azure CLI wrappers), containers (Docker/Podman/K8s).

**Repository Topics (recommended):** ai, prompts, llm, bash, shell-script, linux, automation, devops, sysadmin, scripting, best-practices, kernel, security

Created with ❤️ for the AI + Linux community.