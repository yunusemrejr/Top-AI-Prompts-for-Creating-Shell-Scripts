# Top AI Prompts for Creating Shell Scripts

A curated collection of effective prompts for using LLMs to generate reliable, secure, and efficient Linux shell scripts.

## Overview

This repository provides top prompts to get high-quality shell scripts from AI models like Grok, Claude, GPT, etc.

## Best Practices: Full List of Things to Consider

When prompting LLMs for Linux shell scripts, specify these to ensure quality:

1. **Shebang and Environment**: Always require `#!/usr/bin/env bash` and `set -euo pipefail`.
2. **Strict Mode**: Explain the importance of error handling with `set -euo pipefail`.
3. **Argument Parsing**: Use `getopts` for options, validate inputs.
4. **Quoting and Safety**: Emphasize proper quoting to prevent injection.
5. **Idempotency and Safety**: Scripts should be safe to rerun.
6. **Dependencies Check**: Include checks for required commands (`command -v`).
7. **Logging and Output**: Use `echo`, `logger`, or functions for output.
8. **Error Trapping**: Use `trap` for cleanup on EXIT, ERR, etc.
9. **Portability**: Specify target (bash-specific or POSIX sh).
10. **Security**: No `eval`, avoid unnecessary `sudo`, sanitize variables.
11. **Testing Recommendations**: Suggest unit tests or dry-run modes.
12. **Documentation**: Require header comments with usage, options, examples.
13. **Performance**: For large operations, consider efficiency.
14. **Destructive Operations**: Require confirmation or --force flag.
15. **Versioning/Compatibility**: Note required bash version if any.

Include these in every prompt: "Write a robust, well-commented bash script that... Include strict mode, error handling, input validation, and usage examples."

## Example Prompts

### 1. Directory Backup Script

**Prompt:**

"Create a bash script called backup.sh that takes a source directory and destination as arguments. Use rsync for incremental backup with timestamped logs. Include:
- Strict bash settings
- Input validation
- Error handling and trap for cleanup
- Dry-run option
- Detailed comments"

**Typical Resulting Script Snippet:**

```bash
#!/usr/bin/env bash
set -euo pipefail

SOURCE="${1:-}" 
DEST="${2:-}"

if [ -z "$SOURCE" ] || [ -z "$DEST" ]; then
  echo "Usage: $0 <source> <dest>" >&2
  exit 1
fi

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOGFILE="backup_${TIMESTAMP}.log"

rsync -av --delete "$SOURCE/" "$DEST/" 2>&1 | tee "$LOGFILE"
```

### 2. System Information Reporter

**Prompt:**

"Generate a Linux monitoring script that reports CPU, memory, disk usage, and running processes. Output in a nice formatted table. Add alerts if usage exceeds thresholds. Make it cron-friendly."

**Typical Script:**

```bash
#!/usr/bin/env bash
set -euo pipefail

# Check CPU
CPU=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
# ... (full script would include more)
echo "CPU Usage: ${CPU}%"
```

### 3. File Organizer

**Prompt:**

"Write a script to organize files in a directory by type (images, docs, etc.) into subfolders. Support recursive option and dry-run."

## Additional Resources

- [Bash Guide](https://www.gnu.org/software/bash/manual/)
- [ShellCheck](https://www.shellcheck.net/) - Always recommend linting generated scripts.

Star the repo if helpful! Contributions welcome via PRs.
