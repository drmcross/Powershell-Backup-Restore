#Created by Drew @ drewmcross.com 
#Last updated Jan 2021

$netshare = #Replace with location of network drives (Ex: \\server.en.iu.edu\users)

#Ask for username
$username = Read-Host -Prompt "Enter the username of the person's files to be backed up"

#Check to see if username folder exists on drive, if not then prompt and exit
if(!(Test-Path -Path C:\users\$username)){
    Write-Host "The username selected does not exist on this computer, run script again with a valid username"
    Start-Sleep -s 15
    exit
    }

Write-Host "Username $username found"

#Check to see if Y: Drive/netshare exists, if so check for existing ISBackup. If so, remove and remake, else create directory.
Write-Host "Checking for Y: Drive"
$smadmin = Read-Host -Prompt "Enter domain\username to use for drive access (Ex ads\smdrc)"
Add-LocalGroupMember -Group "Administrators" -Member $smadmin

New-PSDrive -Name "Q" -PSProvider FileSystem -Root "$netshare\$username" -Credential $smadmin

if(Test-Path -Path Q:\ISBackup){
    Write-Host "ISBackup folder already exists, removing..."
    Remove-Item -LiteralPath "Q:\ISBackup" -Force -Recurse
    Write-Host "ISBackup folder deleted"
}

Write-Host "Creating Y:\ISBackup folder for user"
New-Item -ItemType directory -Path Q:\ISBackup

Write-Host "ISBackup folder created"

#Copy user profile contents into ISBackup Folder, first prompt for preferred browser and backup settings based on which browser
$browser = Read-Host -Prompt "I = Edge, F=Firefox, C=Chrome :"
if($browser -eq "I"){
    Write-Host "Copying Edge favorites"
    New-Item -ItemType directory -Path Q:\ISBackup\EdgeFavorites
    Copy-Item -Path C:\users\$username\Favorites -Destination Q:\ISBackup\EdgeFavorites
    Write-Host "Edge favorites copied successfully"
}

ElseIf($browser -eq "F"){
    Write-Host "Copying Firefox profile and configuration"
    New-Item -ItemType directory -Path Q:\ISBackup\Firefox_Profile
    New-Item -ItemType directory -Path Q:\ISBackup\FFConfigfile
    Copy-Item -Path C:\users\$username\AppData\Roaming\Mozilla\Firefox\Profiles -Destination Q:\ISBackup\Firefox_Profile
    Copy-Item -Path C:\users\$username\AppData\Roaming\Firefox\profiles.ini Q:\ISBackup\FFConfigfile
    Write-Host "Firefox profile copied successfully"
}

ElseIf($browser -eq "C"){
    Write-Host "Copying chrome profile of user"
    New-Item -ItemType Directory -Path Q:\ISBackup\Chrome_Profile
    Remove-Item -Path c:\users\$username\appdata\local\Google\Chrome\user data\default\cache
    Remove-Item -Path c:\users\$username\appdata\local\Google\Chrome\user data\default\code cache\js
    Copy-Item -Path c:\users\$username\appdata\Local\Google\Chrome\User Data\Default -Destination Q:\ISBackup\Chrome_Profile
    Write-Host "Chrome profile copied successfully"
}

# Outlook Signature File

Write-Host "Copying user Outlook signature..."
New-Item -ItemType Directory -Path Q:\ISBackup\OutlookSignatures
Copy-Item -Path C:\users\$username\AppData\Roaming\Microsoft\Signatures -Destination Q:\ISBackup\OutlookSignatures
Write-Host "Outlook signatures copied successfully"

# User Desktop

Write-Host "Copying everything from user desktop, this could take a while..."
New-Item -ItemType Directory -Path Q:\ISBackup\Desktop
Copy-Item -Path C:\Users\$username\Desktop -Destination Q:\ISBackup\Desktop
Write-Host "User Desktop copied Successfully"

# User documents (Users ideally would be saving everything to their netshare automatically, but alas)
Write-Host "Copying user documents..."
New-Item -ItemType Directory -Path Q:\ISBackup\MyDocuments
Copy-Item -Path C:\Users\$username\Desktop -Destination Q:\ISBackup\MyDocuments
Write-Host "User documents copied successfully"

# Outlook Archive Files
Write-Host "Copying Outlook Archive"
New-Item -ItemType Directory -Path Q:\ISBackup\OutlookArchives
Copy-Item -Path c:\users\$username\Appdata\Local\Microsoft\Outlook\*.pst -Destination Q:\ISBackup\OutlookArchives
Copy-Item -Path c:\users\$username\Appdata\Local\Microsoft\Outlook\*.pst -Destination Q:\ISBackup\OutlookArchives
Write-Host "Outlook archives copied successfully"

Remove-PsDrive -Name Q -Force
Remove-LocalGroupMember -Group "Administrators" -Member $smadmin
Write-Host "Backup Complete"
Start-Sleep -s 15
exit