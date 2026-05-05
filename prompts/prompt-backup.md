# Prompt: Robust Timestamped Backup Script

You are an expert Linux sysadmin and bash specialist.

Create a complete, production-ready bash script that performs timestamped backups of a source directory to a destination using tar or rsync. 

MANDATORY REQUIREMENTS:
- set -euo pipefail
- Dry-run mode (--dry-run)
- Retention policy (delete old backups)
- Logging to file + stdout with colors
- Full --help and usage examples
- Input validation
- Extensive comments explaining every section
- Idempotent where possible

Target: Modern Linux (Ubuntu/RHEL). Output ONLY the script in one code block.