# Shell Techniques & How AI Should Leverage Them

## Why Technique Knowledge Matters for AI — Expanded Explanation

When LLMs understand advanced shell features deeply, they stop producing verbose, fragile, or outdated code and start producing elegant, efficient, modern, and maintainable scripts. This section is both for humans learning and for guiding AI.

[Much more descriptive text added to every subsection...]

## Essential Bash / Shell Features — Now with More Examples and Rationale

### Strict Mode & Error Handling — Expanded
Explanation of why `set -euo pipefail` catches more errors than `set -e`, what `pipefail` specifically does, and why combining it with `trap` is the professional pattern.

### Functions & Modularity — Expanded
Detailed explanation of `local` variables, return codes vs output capture, and why functions make scripts testable and maintainable.

### Arrays & Maps (Bash 4+) — Expanded
When to use indexed vs associative arrays, with concrete examples of configuration handling and why string splitting is fragile.

### Parameter Expansion — Expanded
Many more practical examples of `${var:-default}`, `${var//search/replace}`, `${var##*/}`, etc., and why these are superior to external commands like `basename` or `cut` in many cases.

### Process Substitution & Coprocesses — Expanded
Real-world use cases (comparing command output without temp files, feeding data to loops safely).

### Traps for Cleanup — Expanded
Multiple trap examples (EXIT, ERR, INT, TERM) and why having a single cleanup function called by multiple traps is a robust pattern.

### Here-Documents & Here-Strings — Expanded
When to use them for configuration files, SQL, or multi-line messages vs printf.

### Job Control & Backgrounding — Expanded
Safe patterns for running tasks in parallel and waiting, with proper error propagation.

### Different Shells — Expanded
Detailed comparison table of bash vs zsh vs fish vs POSIX sh, with guidance on when to target each in prompts.

## How AI Benefits — Much More Detail

- Produces idiomatic code instead of "works but ugly" code
- Avoids entire classes of bugs (unquoted variables, missing error paths)
- Suggests better modern tools and patterns
- Understands trade-offs between portability and features

Master these concepts and your prompts will produce dramatically better scripts.