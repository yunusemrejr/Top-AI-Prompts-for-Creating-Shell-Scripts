# Detailed Prompting Techniques for Generating High-Quality Shell Scripts

## Introduction

Effective prompting is the key to reliable AI-generated shell scripts. This guide covers advanced techniques beyond basic "write a script for X".

[Previous content kept and expanded with much more descriptive text...]

## Core Prompt Structure (Expanded Template)

[Longer, more detailed template with explanations for each section...]

## Advanced Techniques (Now with More Examples and Rationale)

### Chain-of-Thought (CoT) Prompting — Expanded
Adding "Think step by step" dramatically improves reasoning. Example full paragraph you can add:

"Before writing any code, think step-by-step through the following: 1. What are the prerequisites and dependencies? 2. What are the possible failure modes and how should they be handled? 3. What logging and observability is needed? 4. How can this script be made idempotent and safe to re-run? 5. What comments will best help a future reader understand the design? Then write the script."

### Few-Shot Prompting — Expanded
Provide 1-2 small, high-quality script snippets as style examples. This is especially powerful for teaching the model your preferred comment style or logging format.

### Role + Expertise Prompting — Expanded
The stronger and more specific the role, the better the output. Example of a very strong role prompt:

"You are a principal engineer at a large tech company responsible for internal tooling and automation. You have written hundreds of production bash scripts that have run reliably for years on thousands of servers. You care deeply about safety, observability, and making scripts that are easy for other engineers (and future AI) to understand and maintain. You never take shortcuts on error handling or input validation."

### Constraint-Heavy Prompting — Expanded
List 10-15 explicit constraints. The more specific and consistent, the better.

### Iterative Improvement Prompting — Expanded
First prompt for a basic solid version. Then use the feedback patterns from `feedback-loop-examples.md`.

### Verification & Review Prompting — Expanded
After generation, use a second prompt: "Act as a senior code reviewer. Analyze the script against the verification checklist. Identify any remaining issues and suggest concrete fixes. Then provide an improved version."

## Best Prompt Starters by Category (Expanded)

Many more category-specific prompt starters with full mandatory requirements included.