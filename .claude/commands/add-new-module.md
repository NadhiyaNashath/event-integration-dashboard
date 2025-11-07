---
description: Add a new module to packages.json
---

Add a new Ballerina module entry to the `packages.json` file following the guidelines in `developer-guide.md`.

## Step 1: Gather Required Information

Use the `AskUserQuestion` tool to ask the user to provide:
1. Module name (as free text input via "Other" option)
2. Ballerina organization with options:
   - `ballerina` - Main Ballerina organization
   - `ballerinax` - Extended Ballerina organization for connectors

## Step 2: Ask About Optional Fields

Use the `AskUserQuestion` tool with **multiSelect: true** to ask which optional fields need to be customized (if any differ from defaults):

Explain the defaults first:
- GitHub org: `ballerina-platform`
- Module repository: `module-<org>-<name>`
- Library label: `module/<name>`
- BI label: `eventintegration/<name>`

Options:
- "Custom GitHub organization"
- "Custom module repository name"
- "Custom library label"
- "Custom BI label"
- "Use all defaults" (if user selects this or nothing, use defaults)

## Step 3: Gather Custom Values

For each selected custom field, ask for the specific value using `AskUserQuestion`.

## Step 4: Add to packages.json

1. Read the current `packages.json` file
2. Add the new module entry to the `modules` array with only the required fields plus any custom optional fields
3. Maintain alphabetical order within the modules array if applicable
4. Use the `Edit` tool to add the new module entry

## Step 5: Confirm

Show the user what was added with a summary like:
```
Added new module: activemq
- Organization: ballerinax
- Using defaults:
  - GitHub org: ballerina-platform
  - Repository: module-ballerinax-activemq
  - Library label: module/activemq
  - BI label: eventintegration/activemq
```

## Important Notes

- Only include optional fields in the JSON if they differ from defaults
- For `ballerinax` modules, the repository pattern is often custom (e.g., module-ballerinax-azure-service-bus)
- Labels are used for issue categorization in ballerina-library and Ballerina Integrator repositories
