# ps-AD-passreset

PowerShell helpdesk script to check an AD user, unlock the account if locked, and reset the password.

## Features
- Prompts for a username
- Checks if the account exists
- Shows enabled/disabled status
- Detects if the account is locked
- Optionally unlocks the account
- Generates a new random password (≥1 uppercase, ≥1 symbol from !@#$)
- Resets the account password and enforces **ChangePasswordAtLogon**
- Saves the new password to a text file

## Requirements
- Windows with **RSAT ActiveDirectory** module (or run on a domain controller)
- Permissions to unlock accounts and reset passwords
- PowerShell 5.1+ (or PowerShell 7 with AD module available)

## Usage
From the repo root:
```powershell
pwsh -ExecutionPolicy Bypass -File .\src\Reset-ADUser.ps1
