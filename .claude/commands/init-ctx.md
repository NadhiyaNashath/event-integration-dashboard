---
description: Initialize project context and save to .claude.ctx
---

Initialize the project context by analyzing the codebase structure, key files, and configuration, then save the context to `.claude.ctx` file instead of `CLAUDE.md`.

## Instructions

1. **Analyze the project structure**:
   - Use `Glob` to find key configuration files (package.json, packages.json, *.config.js, etc.)
   - Identify the main directories and their purposes
   - Look for documentation files (README.md, developer-guide.md, etc.)

2. **Read key files**:
   - Read `packages.json` to understand products, modules, and tools
   - Read `developer-guide.md` if it exists
   - Read any README files
   - Check for TypeScript/JavaScript configuration files

3. **Generate context documentation**:
   Create a comprehensive context document with the following sections:

   ```markdown
   # Project Context

   ## Overview
   [Brief description of the project based on README or package.json]

   ## Project Structure
   [Directory structure and key files]

   ## Configuration Files
   - `packages.json`: [Description and current contents summary]
   - [Other config files]

   ## Key Components

   ### Products
   [List products from packages.json with their configurations]

   ### Modules
   [List modules from packages.json with their configurations]

   ### Tools
   [List tools from packages.json with their configurations]

   ## Development Guidelines
   [Summary from developer-guide.md if available]

   ## Dependencies
   [List key dependencies from package.json if available]

   ---
   *Context generated on: [date]*
   ```

4. **Write to `.claude.ctx`**:
   - Use the `Write` tool to create/overwrite `.claude.ctx` with the generated context
   - Include all relevant information discovered during analysis
   - Format it as markdown for readability

5. **Confirm completion**:
   Show the user a summary of what was analyzed and saved to `.claude.ctx`

## Notes

- This file (`.claude.ctx`) serves as persistent context for Claude Code
- It should be updated whenever significant project changes occur
- The file should be human-readable and well-structured
- Include both high-level overview and specific details about configurations
