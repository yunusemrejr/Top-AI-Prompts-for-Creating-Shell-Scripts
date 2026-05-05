# How-to Guide: Using This Repository & Generating Scripts with AI

## Step-by-Step Workflow

1. **Choose or Adapt a Prompt**
   - Browse `prompts/` or copy from README/examples.
   - Customize the task description.

2. **Craft / Enhance the Prompt**
   - Use the full best-practices list from README.
   - Add role, constraints, CoT instructions.

3. **Generate with LLM**
   - Preferred models: Grok (great at code), Claude 3.5/Opus (excellent reasoning), GPT-4o.
   - Temperature: 0.2-0.5 for more deterministic output.

4. **Review & Lint**
   - Paste into https://www.shellcheck.net/
   - Read every line and understand it.
   - Check for security issues (secrets, permissions).

5. **Test Safely**
   - Always use `--dry-run` or `-n` first.
   - Run in a VM, container, or with test data.
   - Test error paths (kill services, remove files, etc.).

6. **Iterate with AI**
   - "Improve this script by adding X and fixing Y."

7. **Deploy & Monitor**
   - Add to cron/systemd timer.
   - Monitor logs.
   - Version control your scripts.

## Recommended LLM Settings
- System prompt: Paste the entire "You are an expert..." template.
- Max tokens: Enough for full script + comments.

## Integration Tips
- VS Code + GitHub Copilot or Continue.dev with custom prompts from this repo.
- Cursor.sh or other AI IDEs.
- Save your best prompts in this repo for reuse.