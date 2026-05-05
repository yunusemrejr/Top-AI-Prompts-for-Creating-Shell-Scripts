# Shell Techniques & How AI Should Leverage Them

## Why Technique Knowledge Matters for AI
When LLMs understand advanced shell features, they generate elegant, efficient, and modern scripts instead of verbose, fragile, or outdated code. This section teaches both humans and AI the idioms that matter.

## Essential Bash / Shell Features

### 1. Strict Mode & Error Handling
```bash
set -euo pipefail
trap 'echo "Error on line $LINENO"; exit 1' ERR
```
AI should always include this by default.

### 2. Functions & Modularity
Use functions with `local` variables. Return values via echo or status codes.

### 3. Arrays & Maps (Bash 4+)
```bash
declare -A config
config[host]="example.com"
```
Better than space-separated strings.

### 4. Parameter Expansion (Powerful, No External Tools)
- Default: `${var:-default}`
- Length: `${#var}`
- Replace: `${var//old/new}`
- Substring: `${var:0:10}`
AI loves these for clean string handling.

### 5. Process Substitution & Coprocesses
`<(command)` and `>(command)` avoid temp files.

### 6. Traps for Cleanup
```bash
tmpfile=$(mktemp)
trap 'rm -f "$tmpfile"' EXIT
```
Critical for safety.

### 7. Here-Documents & Here-Strings
Clean multi-line heredoc for configs or messages.

### 8. Job Control
`cmd & pid=$! ; wait $pid`

### 9. Different Shells
- **Bash**: Most feature-rich, arrays, associative arrays.
- **Zsh**: Excellent completion, themes, but different array syntax.
- **Fish**: User-friendly, but not POSIX.
- **POSIX sh**: Maximum portability (dash, busybox). Avoid bashisms.

**Prompting Tip:** Always tell the AI which shell to target and why.

## How AI Benefits
- Produces idiomatic code (modern parameter expansion instead of `cut`/`awk` everywhere).
- Avoids common anti-patterns (unquoted vars, missing traps).
- Suggests better tools (e.g., `jq` for JSON, `yq` for YAML when appropriate).
- Understands when to use external tools vs pure shell.

Master these and your AI-generated scripts will be top-tier.