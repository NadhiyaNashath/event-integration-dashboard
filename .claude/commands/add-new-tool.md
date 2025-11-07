---
description: Add a new tool to packages.json
---

Add a new Ballerina tool entry to the `packages.json` file following the guidelines in `developer-guide.md`.

## Step 1: Gather Required Information

Use the `AskUserQuestion` tool to ask the user to provide:
1. Tool name (as free text input via "Other" option, often follows pattern `tool.<toolname>`)
2. Ballerina organization with options:
   - `ballerina` - Main Ballerina organization
   - `ballerinax` - Extended Ballerina organization
3. Library label (as free text via "Other", used in ballerina-library repository)
4. BI label (as free text via "Other", used in Ballerina Integrator repositories)

**Important**: library-label and bi-label are REQUIRED fields with no defaults.

## Step 2: Ask About Optional Fields

Use the `AskUserQuestion` tool with **multiSelect: true** to ask which optional fields need to be customized:

Explain the defaults first:
- GitHub org: `ballerina-platform`
- Tool repository: `<name>-tools`

Options:
- "Custom GitHub organization"
- "Custom tool repository name"
- "Use all defaults" (if user selects this or nothing, use defaults)

## Step 3: Gather Custom Values

For each selected custom field, ask for the specific value using `AskUserQuestion`.

## Step 4: Add to packages.json

1. Read the current `packages.json` file
2. Add the new tool entry to the `tools` array with all required fields plus any custom optional fields
3. Maintain alphabetical order within the tools array if applicable
4. Use the `Edit` tool to add the new tool entry

## Step 5: Confirm

Show the user what was added with a summary like:
```
Added new tool: tool.graphql
- Organization: ballerina
- Library label: module/graphql-tools
- BI label: eventintegration/graphql
- Using defaults:
  - GitHub org: ballerina-platform
  - Tool repository: tool.graphql-tools
```

## Important Notes

- Labels are used for issue categorization:
  - `library-label`: Used in https://github.com/ballerina-platform/ballerina-library
  - `bi-label`: Used in https://github.com/wso2/product-ballerina-integrator and https://github.com/wso2/docs-bi
- Tool names often follow the pattern `tool.<toolname>` (e.g., `tool.asyncapi`)
- Both labels are required fields and must be specified
