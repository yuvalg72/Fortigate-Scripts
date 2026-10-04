# Fortigate-Scripts - attributed snapshot fork

> [!IMPORTANT]
> **Upstream provenance:** This repository is a GitHub fork of [ShirKiBakal/Fortigate-Scripts](https://github.com/ShirKiBakal/Fortigate-Scripts). The upstream repository/account remains the source of the original scripts and history.
>
> **Local purpose:** This fork is retained as an attributed reference snapshot of PowerShell examples that generate FortiOS CLI text. It is not presented as first-party authored automation.
>
> **Local modifications and sync state:** Immediately before this provenance-only README was added, GitHub reported the local fork as **0 commits ahead / 2 commits behind** upstream `main`. No local commits ahead of upstream were observed. This remediation intentionally does not synchronize upstream code; it documents the current snapshot state.
>
> **License / rights:** No repository-level `LICENSE` file was observed in the local or upstream root during this audit. This README does not create or imply a license or redistribution permission that was not supplied by the upstream source.

## Current local contents

The local default branch currently contains:

- `FortiGroups-Example.ps1` - reads a CSV and generates FortiOS CLI for firewall address objects and an address group.
- `Example.csv` - example input containing an IP/subnet entry and an FQDN entry.

The upstream repository currently contains additional material that is not present in this local snapshot. Use the upstream repository when you need its latest state.

## Safety

Review generated FortiOS CLI before applying it to a device. Paths, object names, addresses and other values in these examples must be adapted to the intended environment. This repository-level documentation does not validate the generated configuration against a specific FortiOS release or production policy.
