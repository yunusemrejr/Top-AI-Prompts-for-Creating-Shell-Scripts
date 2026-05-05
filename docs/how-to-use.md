# How-to Guide: Using This Repository & Generating Scripts with AI — Expanded

## Step-by-Step Workflow — Now with Much More Detail

1. **Choose or Adapt a Prompt** — Browse `prompts/`, README, or existing scripts. Customize the task description while keeping the mandatory requirements section.

2. **Craft / Enhance the Prompt** — Use the full best-practices list. Add role, constraints, CoT instructions. Reference `best-practices-comprehensive.md`.

3. **Generate with LLM** — Preferred models and why. Temperature recommendations. System prompt usage.

4. **Review & Lint** — ShellCheck + manual review checklist. What to look for in the first 30 seconds.

5. **Test Safely** — Dry-run first, then limited scope, then full. How to create safe test environments (containers, VMs, tmpfs).

6. **Iterate with AI** — Use the feedback loop patterns from `feedback-loop-examples.md`. Typical 1-3 iterations to production quality.

7. **Deploy & Monitor** — Version control, cron/systemd, log monitoring, alerting.

## Recommended LLM Settings — Expanded

Temperature, top_p, max tokens, system prompt strategy.

## Integration Tips — Expanded

VS Code, Continue.dev, Cursor, GitHub Copilot custom instructions, using this repo as a knowledge base for your AI coding assistant.