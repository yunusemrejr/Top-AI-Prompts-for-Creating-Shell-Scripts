# Top AI Prompts for Creating Shell Scripts

**The most comprehensive resource for using AI (LLMs) to generate production-grade Linux shell scripts.**

This repository provides battle-tested prompting strategies, detailed best practices (including exactly **what to mention** and **what NOT to mention** in your prompts), real-world complex examples, feedback loop patterns, and heavily commented scripts that serve as both tools and learning materials.

**Keywords for discoverability:** AI prompts for shell scripts, LLM bash scripting, best practices for AI-generated shell scripts, what to include in prompts for bash, feedback loops for AI code generation, complex shell script examples, Linux automation with AI, prompting techniques shell scripts, secure robust bash with LLMs, DevOps AI scripting guide.

## Table of Contents
- [Overview](#overview)
- [What to Mention in Prompts (Comprehensive Guide)](#what-to-mention-in-prompts-comprehensive-guide)
- [What NOT to Mention in Prompts](#what-not-to-mention-in-prompts)
- [Feedback Loops: How to Iterate with AI Agents](#feedback-loops-how-to-iterate-with-ai-agents)
- [Complex Example Scripts & AI Output Showcase](#complex-example-scripts--ai-output-showcase)
- [All Documentation](#all-documentation)
- [Example Scripts Library](#example-scripts-library)
- [Pure Prompt Templates](#pure-prompt-templates)

## Overview

AI can generate shell scripts incredibly fast, but without proper prompting, the output is often fragile, insecure, poorly documented, or missing critical production features like error handling, dry-run modes, and logging.

This repo solves that by providing:

- Exact lists of what **must** be in every prompt
- What to **avoid** saying (to prevent over-constraining or conflicting instructions)
- Real examples of good vs bad AI output + how to give effective feedback
- Heavily commented scripts that teach *why* certain patterns exist
- Complex, multi-feature scripts that demonstrate professional-grade results

## What to Mention in Prompts (Comprehensive Guide)

See the dedicated guide: `docs/best-practices-comprehensive.md`

**Core things you should almost always mention:**

1. **Role & Expertise** — "You are a senior Linux sysadmin and expert bash developer with 15+ years in production environments."
2. **Strict Technical Requirements** — shebang, `set -euo pipefail`, trap for errors, input validation, proper quoting.
3. **Safety & Robustness Features** — dry-run mode, idempotency, dependency checks, least privilege.
4. **Observability** — logging (file + stdout + syslog), colored output, structured output (JSON).
5. **Documentation Style** — "Add extensive comments that explain *why* each section exists, not just what it does."
6. **Target Environment** — Distro/kernel version, bash version, specific tools available.
7. **Output Format** — "Output ONLY the complete script in one markdown code block. No extra text outside."
8. **Verification Mindset** — Ask the AI to self-review against a checklist or to make the script pass ShellCheck.
9. **Edge Cases & Failure Modes** — Explicitly ask it to handle common failure scenarios.
10. **Maintainability** — Prefer functions over one-liners for complex logic; readability first.

## What NOT to Mention in Prompts

See full details in `docs/best-practices-comprehensive.md`.

**Common mistakes to avoid:**
- Do **not** say "make it as short as possible" if you want good comments and robustness.
- Do **not** give conflicting instructions (e.g., "use only POSIX sh" and then "use associative arrays").
- Do **not** over-specify syntax details unless you have a very good reason (let the AI use modern idioms).
- Do **not** forget to mention safety features — AI will often skip dry-run and error handling if not explicitly asked.
- Avoid vague instructions like "make it good" without defining what "good" means in your context.
- Do **not** ask for "no comments" unless you truly want minimal code (rarely useful).

## Feedback Loops: How to Iterate with AI Agents

See the full guide with before/after examples: `docs/feedback-loop-examples.md`

**Effective Feedback Pattern:**

1. Generate initial version.
2. Review it yourself or with ShellCheck.
3. Give specific, constructive feedback: "Improve the previous script by adding X because Y. Fix Z by doing W. Add comments explaining the changes."
4. Iterate 1-3 times.

This repo includes concrete examples of mediocre AI output → high-quality feedback → significantly improved script.

## Complex Example Scripts & AI Output Showcase

See `/examples/` for production-ready scripts and `docs/complex-examples-showcase.md` for analysis of what makes a great AI-generated script.

New complex examples added:
- Full-featured monitoring + alerting lite
- Multi-distro package + service manager
- Encrypted backup with verification + rotation
- Advanced network diagnostics with remediation suggestions

## All Documentation

- `docs/best-practices-comprehensive.md` — The definitive guide on what to say and what not to say in prompts + expanded explanations.
- `docs/feedback-loop-examples.md` — Real before/after AI outputs + feedback examples.
- `docs/prompting-techniques.md` — Chain-of-thought, few-shot, role prompting, etc. (greatly expanded).
- `docs/shell-techniques.md` — Advanced shell features and why AI should know them (expanded with more examples).
- `docs/how-to-use.md`, `docs/verification-checklist.md`, `docs/common-pitfalls.md`, `docs/ai-benefits.md` — All significantly expanded with more descriptive text.

## Example Scripts Library

All scripts now contain **extensive educational comments** explaining the reasoning behind every major section. They are designed to be both useful tools and teaching materials.

## Pure Prompt Templates

Located in `/prompts/`. Copy-paste ready and include all mandatory requirements.

---

**Star this repo if it helps you write better shell scripts with AI! Contributions welcome.**