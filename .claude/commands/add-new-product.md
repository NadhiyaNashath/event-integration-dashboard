---
description: Add a new product to packages.json
---

Add a new product entry to the `packages.json` file following the guidelines in `developer-guide.md`.

## Step 1: Gather Required Information

Use the `AskUserQuestion` tool to ask the user to provide:
1. Product name (as free text input via "Other" option)
2. Organization name (as free text input via "Other" option, typically `wso2`)

## Step 2: Ask About Optional Fields

Use the `AskUserQuestion` tool with **multiSelect: true** to ask which optional fields need to be customized (if any differ from defaults):

Explain the defaults first:
- GitHub org: Same as organization
- Product repository: `product-<name>`
- Documentation repository: `docs-<name>`
- Helm repository: `helm-<name>`

Options:
- "Custom GitHub organization"
- "Custom product repository name"
- "Custom documentation repository name"
- "Custom helm repository name"
- "Use all defaults" (if user selects this or nothing, use defaults)

## Step 3: Gather Custom Values

For each selected custom field, ask for the specific value using `AskUserQuestion`.

## Step 4: Add to packages.json

1. Read the current `packages.json` file
2. Add the new product entry to the `products` array with only the required fields plus any custom optional fields
3. Maintain alphabetical order within the products array if applicable
4. Use the `Edit` tool to add the new product entry

## Step 5: Confirm

Show the user what was added with a summary like:
```
Added new product: mi
- Organization: wso2
- Using defaults:
  - GitHub org: wso2
  - Product repository: product-mi
  - Documentation repository: docs-mi
  - Helm repository: helm-mi
```

## Important Notes

- Only include optional fields in the JSON if they differ from defaults
- Most products follow the default naming convention
