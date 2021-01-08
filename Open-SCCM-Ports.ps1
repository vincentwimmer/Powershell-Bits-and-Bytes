# For workstations with strict firewall rules.
New-NetFirewallRule -DisplayName "SCCM Ports" -Direction Inbound -LocalPort 80,443,1433,4022 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "SCCM Ports" -Direction Outbound -LocalPort 80,443,1433,4022 -Protocol TCP -Action Allow
