# Common Pitfalls in AI-Generated Shell Scripts & How to Avoid Them — Greatly Expanded

## Introduction

This document catalogs the most frequent problems seen in AI-generated shell scripts and provides concrete prevention strategies. Most of these problems can be eliminated simply by including the requirements from `best-practices-comprehensive.md` in every prompt.

## Top Pitfalls — Now with More Examples and Detailed Fixes

1. **Missing or Incorrect Quoting** — Symptoms, real-world damage examples (rm -rf on wrong files), and the exact prompt language that prevents it.

2. **No or Weak Error Handling** — Why scripts that "mostly work" are dangerous in production. The trap + cleanup pattern.

3. **Hardcoded Values & Secrets** — Security and portability problems. Better patterns (env vars, config files, CLI flags).

4. **Ignoring Distro Differences** — apt vs dnf vs pacman, systemd vs SysVinit, /etc vs /usr/etc. How to prompt for conditional or distro-aware code.

5. **Overly Clever One-Liners** — Readability vs cleverness trade-off. When one-liners are acceptable and when they are not.

6. **Missing Dry-Run / Confirmation** — Real stories of near-disasters. The importance of `--dry-run` for any script that can cause damage.

7. **Deprecated or Non-Portable Commands** — ifconfig vs ip, netstat vs ss, etc. How to steer the AI toward modern tools.

8. **No Logging or Observability** — Why scripts that run in cron without logging are nightmares to debug. Structured logging patterns.

9. **Inconsistent Exit Codes** — Why exit codes matter for orchestration tools and monitoring.

10. **Poor Comment Quality** — "what" comments vs "why" comments. How to ask for educational comments.

## Prevention Strategy

The single most effective prevention is to include the full mandatory requirements list from the best-practices document in every single prompt you use. This one habit eliminates the majority of the pitfalls listed above.