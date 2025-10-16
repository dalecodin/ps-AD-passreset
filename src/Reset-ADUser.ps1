$user = Read-Host "Enter the username" 

$UserCheck = Get-ADUser -Filter "SamAccountName -eq '$user'" 

if ($UserCheck -eq $null) {
    Write-Output "User not found" 
    exit 
            } 
else { 
    Write-Output "User found" 
    $PropertiesCheck = $true 
    } 

if ($PropertiesCheck) { 
    
    $isEnabled = Get-ADUser -Identity $user -Properties Enabled
    $isLocked = Get-ADUser -Identity $user -Properties LockedOut
     
if ($isEnabled.Enabled -eq $true) { 
    Write-Output "User is enabled" 
                                   } 
else { 
    Write-Output "User is disabled"
    exit
      } 

if ($isLocked.LockedOut -eq $true) {
    Write-Output "Account Locked"
    $AccUnlockCmd = $true
                          }
else {
    Write-Output "Account Unlocked"
      }
                    }

if ($AccUnlockCmd -eq $true) {

    $unlock = Read-Host "Would you like to unlock Y/N ? "

if ($unlock -ieq "Y") {
    Unlock-ADAccount -Identity $user
    Write-Output "acc now unlocked"
    $NewPass = $true
                      }
else {
    exit
      }
    }

# PASSWORD GEN FROM CHATGPT
function New-RandomPassword {
    param(
        [int]$Length = 9,
        [switch]$AsSecureString  # if set, output will be a SecureString
    )

    # Character sets
    $upper   = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".ToCharArray()
    $lower   = "abcdefghijklmnopqrstuvwxyz".ToCharArray()
    $symbols = "!@#$".ToCharArray()

    # Ensure required characters
    $chars = @()
    $chars += ($upper   | Get-Random -Count 1)   # at least one uppercase
    $chars += ($symbols | Get-Random -Count 1)   # at least one symbol

    # Pool = mostly letters, but can include symbols
    $pool = $upper + $lower + $lower + $lower + $symbols   # weighted toward letters
    $remaining = $Length - $chars.Count

    1..$remaining | ForEach-Object { $chars += ($pool | Get-Random -Count 1) }

    # Shuffle
    $shuffled = $chars | Get-Random -Count $chars.Count
    $password = -join $shuffled

    # Output plaintext or SecureString
    if ($AsSecureString) {
        return (ConvertTo-SecureString $password -AsPlainText -Force)
    } else {
        return $password
    }
}

if ($NewPass) {
    Set-ADAccountPassword -Identity $user -NewPassword (ConvertTo-SecureString $password -AsPlainText -Force) -Reset

    $filename = $user + "password.txt"
    $PassPath = "C:\Users\HelpDeskAdmin\Documents\passwords\$filename"

    Set-Content -Path $PassPath -Value $password

    Write-Output "Password changed to $password and is stored at $PassPath"

    Set-ADUser -Identity $user -ChangePasswordAtLogon $true
else: 
    Write-Output "Error"
                }