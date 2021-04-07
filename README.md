# Powershell Backup/Restore
Powershell utility that backs up common user files from C: to a users Network Drive. Useful for when you're giving a new machine to a user and they might have app settings/files on C: itself. Stores all backed up data to an ISBackup folder in the root of the users Network drive.
 
What the backup grabs:

Edge/Firefox/Chrome user data and configuration files (Prompts for preferred browser)
Outlook Signatures
Desktop data from C:
Documents data from C:
Outlook Archive Files (pst and ost)

In order to use this all you'll need to do is set the Network Share location var to the location of your user network shares. You'll also need to auth with appropriate domain credentials after running the script

Restore will be fairly self explanatory, I'll update repo with it once I finish a rewrite.
