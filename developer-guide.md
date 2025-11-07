# Developer Guide

## Overview

The `packages.json` file is the source of truth for identifying products, modules, and tools managed by the Event Integration team. This guide explains how to configure each section.

## Configuration Structure

The `packages.json` file contains three main sections:

1. **products** - Event Integration team products
2. **modules** - Ballerina modules
3. **tools** - Ballerina tools

---

## Products Section

Products managed by the Event Integration team.

### Required Fields

| Field | Description | Example |
|-------|-------------|---------|
| `name` | Product name | `"si"` |
| `org` | Organization name (typically matches GitHub org) | `"wso2"` |

### Optional Fields

| Field | Description | Default | When to Use |
|-------|-------------|---------|-------------|
| `github-org` | GitHub organization (if different from `org`) | Value of `org` | Only if GitHub org differs from product org |
| `product-repository` | GitHub repository name for product source code | `product-<name>` | Only if repo name differs from default |
| `documentation-repository` | GitHub repository name for product documentation | `docs-<name>` | Only if repo name differs from default |
| `helm-repository` | GitHub repository name for Helm charts | `helm-<name>` | Only if repo name differs from default |

### Examples

**Minimal configuration (uses all defaults):**
```json
{
    "name": "websubhub",
    "org": "wso2"
}
```
Defaults:
- Repository: `product-websubhub`
- Documentation: `docs-websubhub`
- Helm: `helm-websubhub`

**Custom repository name:**
```json
{
    "name": "si",
    "org": "wso2",
    "product-repository": "product-streaming-integrator"
}
```

---

## Modules Section

Ballerina modules managed by the Event Integration team.

### Required Fields

| Field | Description | Example |
|-------|-------------|---------|
| `name` | Ballerina module name | `"mqtt"` |
| `org` | Ballerina organization | `"ballerina"` or `"ballerinax"` |

### Optional Fields

| Field | Description | Default | When to Use |
|-------|-------------|---------|-------------|
| `github-org` | GitHub organization | `ballerina-platform` | Only if different from default |
| `module-repository` | GitHub repository name | `module-<org>-<name>` | Only if repo name differs from default |
| `library-label` | Issue label in [ballerina-library](https://github.com/ballerina-platform/ballerina-library) | `module/<name>` | Only if label differs from default |
| `bi-label` | Issue label in [Ballerina Integrator](https://github.com/wso2/product-ballerina-integrator) and [docs](https://github.com/wso2/docs-bi) | `eventintegration/<name>` | Only if label differs from default |

### Examples

**Minimal configuration (uses all defaults):**
```json
{
    "name": "mqtt",
    "org": "ballerina"
}
```
Defaults:
- Repository: `module-ballerina-mqtt`
- Library label: `module/mqtt`
- BI label: `eventintegration/mqtt`

**Custom repository name:**
```json
{
    "name": "asb",
    "org": "ballerinax",
    "module-repository": "module-ballerinax-azure-service-bus"
}
```

---

## Tools Section

Ballerina tools managed by the Event Integration team.

### Required Fields

| Field | Description | Example |
|-------|-------------|---------|
| `name` | Ballerina tool name | `"tool.asyncapi"` |
| `org` | Ballerina organization | `"ballerina"` |
| `library-label` | Issue label in [ballerina-library](https://github.com/ballerina-platform/ballerina-library) | `"module/asyncapi-tools"` |
| `bi-label` | Issue label in [Ballerina Integrator](https://github.com/wso2/product-ballerina-integrator) and [docs](https://github.com/wso2/docs-bi) | `"eventintegration/asyncapi"` |

### Optional Fields

| Field | Description | Default | When to Use |
|-------|-------------|---------|-------------|
| `github-org` | GitHub organization | `ballerina-platform` | Only if different from default |
| `tool-repository` | GitHub repository name | `<name>-tools` | Only if repo name differs from default |

### Example

```json
{
    "name": "tool.asyncapi",
    "org": "ballerina",
    "tool-repository": "asyncapi-tools",
    "library-label": "module/asyncapi-tools",
    "bi-label": "eventintegration/asyncapi"
}
```

---

## Best Practices

1. **Only specify optional fields when they differ from defaults** - This keeps the configuration clean and maintainable.
2. **Use consistent naming** - Follow the established naming conventions for repositories and labels.
3. **Validate your changes** - Ensure the dashboard correctly identifies repositories and labels after updates.
