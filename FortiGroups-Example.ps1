# Generates FortiGate address objects and one address group from a CSV file.

[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [ValidateNotNullOrEmpty()]
    [string]$GroupName = "Example",

    [Parameter(Mandatory = $false)]
    [ValidateNotNullOrEmpty()]
    [string]$InputPath = "C:\temp\Example.csv",

    [Parameter(Mandatory = $false)]
    [ValidateNotNullOrEmpty()]
    [string]$OutputPath = "C:\temp\Example.txt"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $InputPath -PathType Leaf)) {
    throw "CSV file not found: $InputPath"
}

$csv = Import-Csv -LiteralPath $InputPath
if (-not $csv) {
    throw "CSV file contains no address objects: $InputPath"
}

$requiredColumns = @("name", "value", "type", "set")
$availableColumns = @($csv[0].PSObject.Properties.Name)
$missingColumns = @($requiredColumns | Where-Object { $_ -notin $availableColumns })
if ($missingColumns.Count -gt 0) {
    throw "CSV file is missing required columns: $($missingColumns -join ', ')"
}

$duplicateNames = @($csv | Group-Object -Property name | Where-Object Count -gt 1)
if ($duplicateNames.Count -gt 0) {
    throw "CSV file contains duplicate object names: $($duplicateNames.Name -join ', ')"
}

$lines = [System.Collections.Generic.List[string]]::new()
$members = [System.Collections.Generic.List[string]]::new()

$lines.Add("config firewall address")
foreach ($line in $csv) {
    foreach ($column in $requiredColumns) {
        if ([string]::IsNullOrWhiteSpace([string]$line.$column)) {
            throw "Object '$($line.name)' contains an empty '$column' value."
        }
    }

    $lines.Add("edit `"$($line.name)`"")
    $lines.Add("set type $($line.type)")
    $lines.Add("set $($line.set) $($line.value)")
    $lines.Add("next")
    $members.Add("`"$($line.name)`"")
}
$lines.Add("end")
$lines.Add("")
$lines.Add("config firewall addrgrp")
$lines.Add("edit `"$GroupName`"")
$lines.Add("set member $($members -join ' ')")
$lines.Add("next")
$lines.Add("end")

$outputDirectory = Split-Path -Parent $OutputPath
if ($outputDirectory -and -not (Test-Path -LiteralPath $outputDirectory)) {
    New-Item -ItemType Directory -Path $outputDirectory -Force | Out-Null
}

$lines | Set-Content -LiteralPath $OutputPath -Encoding UTF8
Write-Host "FortiGate CLI written to: $OutputPath"
