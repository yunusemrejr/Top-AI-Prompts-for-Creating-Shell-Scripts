# Detailed Prompting Techniques for Generating High-Quality Shell Scripts

## Introduction
Effective prompting is the key to reliable AI-generated shell scripts. This guide covers advanced techniques beyond basic "write a script for X".

## Core Prompt Structure (Template)

```
You are an expert senior Linux systems administrator and bash scripting specialist with 15+ years of production experience.

Task: [Clear description of what the script must do]

Requirements (MANDATORY - include all):
- Shebang: #!/usr/bin/env bash
- Strict mode: set -euo pipefail
- Comprehensive error handling with trap functions for ERR, EXIT, INT
- Input validation for all arguments and user input
- Proper quoting of all variables ("$var")
- Dry-run / simulation mode support (--dry-run or -n)
- Logging: both to stdout (with colors) and to file + syslog via logger
- Built-in --help with usage examples and detailed comments
- Idempotency where applicable (check before create/modify/delete)
- Dependency checks with helpful install messages
- Security: no eval unless sanitized, least privilege, no hardcoded secrets
- Portability notes or distro-specific conditionals
- Output structured where possible (JSON for machine parsing)
- Extensive inline comments explaining WHY each section exists

Additional Features to Include:
- [list specific features]

Constraints:
- Target: Ubuntu 22.04+ / RHEL 8+ / etc.
- No external dependencies beyond standard tools unless specified
- Keep readable and maintainable (functions over one-liners where complex)

Output Format: Output ONLY the complete, ready-to-run script inside a single markdown code block. No surrounding text.
```

## Advanced Techniques

### 1. Chain-of-Thought (CoT) Prompting
Add: "Think step-by-step before writing code: 1. Identify prerequisites and dependencies. 2. Design argument parsing. 3. Plan error paths and cleanup. 4. Implement core logic. 5. Add logging and help."

### 2. Few-Shot / Example-Driven
Include 1-2 short good script snippets in the prompt as examples of style.

### 3. Role + Expertise Prompting
"You are a world-class bash hacker who has contributed to major projects like systemd, coreutils, and cloud-init. You prioritize safety, readability, and robustness over cleverness."

### 4. Constraint-Heavy Prompting
List 10-15 explicit constraints. The more specific, the better the output.

### 5. Iterative Improvement Prompting
First prompt: basic version. Then: "Improve the previous script by adding X, fixing Y, enhancing Z. Explain changes in comments."

### 6. Verification & Review Prompting
After generation: "Act as a code reviewer. Analyze the script for security vulnerabilities, missing error handling, performance issues, and non-idiomatic bash. Suggest concrete fixes."

### 7. Output Control
"Generate the script. Then provide a separate 'Testing Recommendations' section with commands to validate it."

## Best Prompt Starters by Category
- Backup/Archival: "Create an idempotent, encrypted, timestamped backup script with verification and retention policy..."
- Security/Hardening: "Generate a script that audits and hardens SSH, firewall, and kernel parameters with backups of original configs..."
- Monitoring: "Build a lightweight monitoring script that checks services, resources, and logs, outputting JSON for easy parsing..."

Use these techniques consistently and you will get dramatically better results from any LLM.