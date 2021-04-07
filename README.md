# Powershell Backup/Restore
Powershell utility that backs up common user files from C: to a users Network Drive. Has been useful for when I'm giving a new machine to a user and they might have app settings/files on C: itself. Ideally all personal files would already be saved to their net share space, but oh well. Stores all backed up data to an ISBackup folder in the root of the users Network drive.
 
What the backup grabs:

- Edge/Firefox/Chrome user data and configuration files (Prompts for preferred browser)
- Outlook Signatures
- Desktop data from user on C:
- Documents data from user on C:
- Outlook Archive Files (pst and ost)

In order to use this all you'll need to do is set the Network Share location variable to the location of your user network shares. You'll also need to auth with appropriate domain credentials after running the script.

To do:
- Error handling
- Finish a rewrite of accompanying restore script, will update with once finished.

