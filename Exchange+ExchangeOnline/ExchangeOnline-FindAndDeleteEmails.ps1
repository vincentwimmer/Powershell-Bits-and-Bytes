# Head over to https://compliance.microsoft.com/
# Access "Content Search" and create a new search.
# Name your SearchAction and fill out rules.
# Save & Run the SearchAction.

# Once completed, review the results and continue in PowerShell.

# Install, update, and/or import the Exhcange extension if you haven't already.
Connect-IPPSSession

New-ComplianceSearchAction -SearchName "nameOfSearchAction" -Purge -PurgeType HardDelete
# Accept

# Check on status
Get-ComplianceSearchAction
