# FortiGate Scripts

PowerShell utilities for generating reviewed FortiGate CLI from structured input.

## Status

- **Classification:** PowerShell operational tooling
- **Audience:** Network and security engineers
- **Production use:** Generated CLI must be reviewed and validated before application
- **Supported runtime:** Windows PowerShell 5.1 or PowerShell 7+

## Included utility

### `FortiGroups-Example.ps1`

Reads address objects from CSV and generates:

- `config firewall address` entries;
- one `config firewall addrgrp` containing the generated objects.

Required CSV columns:

| Column | Purpose |
|---|---|
| `name` | FortiGate object name |
| `value` | Subnet, IP address, or FQDN value |
| `type` | FortiGate address type |
| `set` | FortiGate field used for the value, such as `subnet` or `fqdn` |

Example:

```powershell
.\FortiGroups-Example.ps1 `
  -GroupName "Approved_Services" `
  -InputPath "C:\temp\Approved_Services.csv" `
  -OutputPath "C:\temp\Approved_Services.conf"
```

## Safety and validation

The script validates required CSV columns, empty values, duplicate names, and input-file availability. It creates a new output file rather than appending repeated configuration.

Before applying the generated CLI:

1. review every object name and value;
2. confirm FortiOS and VDOM compatibility;
3. check for collisions with existing objects;
4. take a current FortiGate configuration backup;
5. paste or import the CLI in a controlled change window;
6. review FortiGate CLI errors and verify the resulting objects and group;
7. remove the generated objects or restore the backup if validation fails.

## Security

Do not place credentials, private keys, tokens, customer configuration backups, or confidential infrastructure data in the CSV or generated output. Treat generated configuration as sensitive when it contains internal addresses or customer-specific names.

## Development checks

Changes should pass PowerShell parsing and PSScriptAnalyzer. Pester tests should be added when the utility gains additional behavior or supported input types.

## Disclaimer

This repository provides operational examples. The executing engineer remains responsible for review, approval, testing, and rollback readiness.
