#  Demonstration
This lab demo walks through setting up the **Account Lockout Policy** in Active Directory, then using the **Password Reset & Unlock Script**.

##  Prerequisites
- Active Directory already set up  
- Logged in as **Domain Admin**  
- Client computer joined to the domain  

##  Step 1 – Open Group Policy Management
In **Windows Server Manager**, go to **Group Policy Management**.  
<img width="1917" height="1030" alt="image" src="https://github.com/user-attachments/assets/d45e8cdf-3fad-4dbf-bfd0-14d0e39da8eb" />


##  Step 2 – Edit Default Domain Policy
Navigate to your forest → **Default Domain Policy** → **Edit**.  
<img width="1916" height="1032" alt="image" src="https://github.com/user-attachments/assets/fc605e18-ae61-4209-8b27-dbd5c849e57c" />


##  Step 3 – Locate Account Policies
Go to:  
```
Computer Configuration → Windows Settings → Security Settings → Account Policies
```
<img width="1918" height="1032" alt="image" src="https://github.com/user-attachments/assets/4ed78bfb-ade0-4f06-b0bd-1d796d0ea939" />


##  Step 4 – Configure Account Lockout
Update the lockout settings. Example configuration:  
- **Account lockout duration** → 10 minutes
- **Account lockout threshold** → 5 invalid attempts  
- **Reset account lockout counter after** → 10 minutes    
<img width="573" height="250" alt="image" src="https://github.com/user-attachments/assets/14fc5a44-8983-47e4-ae37-2e12eed0f236" />


##  Step 5 – Update Group Policy
Force a group policy update with:  
```powershell
gpupdate /force
```
<img width="923" height="138" alt="image" src="https://github.com/user-attachments/assets/0752dc0c-067c-4e58-96d3-eb10f82e8118" />


##  Step 6 – Test on Client Machine
Try logging into a client account with the wrong password until the account locks.  
![20251030-0033-03 9651193](https://github.com/user-attachments/assets/4634114b-d289-4fbe-b785-e78288cfce47)


##  Step 7 – Run the Password Reset Script
On your admin machine, run the script from this repo:  
```powershell
.\Reset-AdPassword.ps1
```
or open in your IDE
![20251030-1435-11 5353189-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/1987b38b-0756-4fb2-ac26-83cca90ab22b)


![Admin Script Run](media/your-gif2.gif)

##  Step 8 – Verify Login Works
Now log back into the client account with the **newly generated password**.  
![20251030-0037-56 1944478](https://github.com/user-attachments/assets/9a1c0255-378b-4215-918b-d760f63d432d)


##  All Done!
The account was:  
- Locked out after failed attempts 
- Unlocked and password reset by the script 
- Able to log in again  

>  **Note:** Normally, users would be prompted to change their password at next login. For this demo, that setting was disabled because it does not work with RDP.
