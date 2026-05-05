# Comprehensive Best Practices for Writing Shell Scripts with AI

## Introduction — Why This Matters

When working with Large Language Models to generate shell scripts, the quality of the **prompt** determines 80-90% of the quality of the output. A vague prompt produces vague, fragile, or even dangerous scripts. A precise, well-structured prompt produces robust, secure, well-documented, and maintainable code.

This document provides the **definitive guide** on exactly what you should mention in your prompts and — equally important — what you should **avoid** mentioning. It is the result of extensive testing across multiple models (Grok, Claude, GPT-4 class) and real-world production use.

## Part 1: What You SHOULD Mention in Almost Every Prompt

### 1. Role and Expertise Framing (Very High Impact)
Always start with a strong role prompt. This sets the "persona" the model adopts.

**Good examples:**
- "You are a senior Linux systems administrator and expert bash developer with 15+ years of experience maintaining production systems at scale."
- "You are a world-class bash scripting specialist who has contributed to major open source projects and prioritizes safety, readability, and long-term maintainability above clever one-liners."

**Why it works:** Models perform significantly better when given an expert persona. They recall more advanced patterns and are more cautious about dangerous operations.

### 2. Mandatory Technical Foundations
You must explicitly list these — the model will often omit them otherwise:

- Shebang: `#!/usr/bin/env bash`
- Strict mode: `set -euo pipefail`
- Comprehensive error handling with `trap` for ERR, EXIT, INT, TERM
- Input validation for every argument and user input
- Proper quoting of **all** variables (`"$var"`)
- Dependency checking with `command -v` and helpful messages

### 3. Safety & Production Features (Critical)
These are the features that separate toy scripts from production scripts:

- **Dry-run / simulation mode** (`--dry-run` or `-n` flag) — especially important for any script that modifies state
- **Idempotency** — the script should be safe to run multiple times
- **Least privilege** — avoid `sudo` unless absolutely necessary; warn the user
- **No hardcoded secrets** — use environment variables or config files
- **Cleanup on failure** — trap functions that remove temp files, unmount, etc.

### 4. Observability & Debugging
- Logging to both stdout (with colors) **and** a log file
- Optional: logging to syslog via `logger`
- Structured output (JSON) when the script is meant to be consumed by other tools
- Meaningful exit codes

### 5. Documentation & Educational Value
- "Add extensive inline comments that explain **why** each section exists and what problem it solves."
- "Include a comprehensive usage/help function with examples."
- "The comments should be educational so that someone reading the script learns best practices."

### 6. Target Environment & Constraints
- Target distribution and version (Ubuntu 22.04+, RHEL 8+, etc.)
- Bash version assumptions (bash 4+ for associative arrays, etc.)
- Specific tools that must be available
- Portability requirements (POSIX sh vs bash-specific)

### 7. Output Format Control
- "Output ONLY the complete, ready-to-run script inside a single markdown code block. Do not add any explanations or text outside the code block unless specifically asked."
- This prevents the model from adding long preambles or splitting the script across multiple blocks.

### 8. Self-Review & Quality Gates
- Ask the model to review its own output against the verification checklist (see `verification-checklist.md`)
- "Make sure the script would pass ShellCheck with minimal warnings."
- "Handle common edge cases and failure modes explicitly."

### 9. Maintainability & Readability
- "Prefer well-named functions over long one-liners for complex logic."
- "Use local variables inside functions."
- "Keep the script readable and maintainable for future humans (and future AI)."

## Part 2: What You Should NOT Mention (or Be Careful About)

### 1. Do NOT Say "Make it as short as possible" or "Keep it concise"

**Why this is harmful:**
When you say this, the model often removes:
- Helpful comments
- Error handling
- Input validation
- Dry-run logic
- Logging

**Better alternative:** "Make the script as robust and well-documented as possible while remaining reasonably concise. Prioritize safety and clarity over brevity."

### 2. Do NOT Give Conflicting or Impossible Constraints

Examples of bad conflicting instructions:
- "Use only POSIX sh" + "Use associative arrays and trap ERR" (associative arrays are bash 4+)
- "Make it very short" + "Add extensive comments and full error handling"
- "Use no external commands" + "Parse complex JSON"

**Fix:** Be consistent. If you want POSIX portability, accept its limitations. If you want modern features, target bash 4+ or 5+.

### 3. Do NOT Over-Specify Syntax Details Unless Necessary

Let the model use modern, idiomatic bash features (parameter expansion, process substitution, etc.) unless you have a specific reason to avoid them.

Bad example: "Do not use any parameter expansion or arrays. Use only cut, awk, and sed."

Good example: "Use modern bash features (parameter expansion, arrays, functions) for clarity and efficiency."

### 4. Do NOT Forget to Explicitly Ask for Safety Features

If you do not mention dry-run, error handling, or quoting, many models will produce scripts that:
- Have no error handling
- Perform destructive operations without confirmation
- Are full of unquoted variables

**Rule:** If it is important for production use, **explicitly list it** in the requirements section of your prompt.

### 5. Do NOT Use Vague Quality Instructions Without Definition

Bad: "Make it good."
Better: "Make it production-ready: robust error handling, comprehensive logging, dry-run support, extensive comments explaining design decisions, and passes ShellCheck."

### 6. Do NOT Ask for "No Comments" or "Minimal Comments"

Unless you have a very specific reason (e.g., golfing or extremely constrained environments), always ask for good comments. Comments are one of the highest-value outputs from AI for learning and maintenance.

### 7. Do NOT Micromanage Every Implementation Detail

Give the model room to choose good patterns. Over-specifying implementation details often leads to worse code because the model tries to satisfy conflicting or overly rigid constraints.

## Part 3: Prompt Template Structure (Recommended)

```
You are [strong expert role].

Task: [clear one-sentence description]

MANDATORY REQUIREMENTS (include all of these):
- Shebang and set -euo pipefail
- Comprehensive error handling with trap
- Input validation + helpful error messages
- Proper quoting of all variables
- Dry-run mode for destructive operations
- Logging to stdout (colors) + file + syslog
- Extensive comments explaining WHY
- --help function with examples
- Dependency checks
- Idempotency where applicable
- Target: [distro/kernel]

Additional features: [list]

Output format: ONLY the complete script in one code block.
```

## Part 4: Testing Your Prompts

After writing a prompt, test it with 2-3 different models. The best prompts work well across Grok, Claude, and GPT-class models. If a prompt only works well on one model, it may be too tuned to that model's quirks.

---

**This document is the single most important file in the repository for improving your AI-generated shell scripts.** Read it, internalize it, and use the requirements list in every prompt you create.