# purgeFiles for MEOS Backups at Kreativmedia

## History
Previously the MEOS websites were backed up on a server that originally was located at the MEOS offices. With a move to new location in Zürich, the ability to securely have the backup server on the same internet connection without a security risk to the internal network was questioned. With the limited use of the server, the unused empty hosting at Kreativmedia, and other factors it seemed an appropriate time to decommission the MEOS Backup Server.

The website backup storage was moved to an unused webhosting account at Kreativmedia that was previously used for hosting the now defunct traumlandschweiz.ch.

## purgeFiles
On the MEOS Backups Server the python program [`purgeFiles`](https://github.com/doofdoofsf/purgeFiles) was installed to purge backup files after a period of time. Read the [README.md](README.md) for more informaton about how to configure this. Te current configuration for the weekly MEOS website backups looks like this in the file `.purgemeosbackups`.
```
# Desired ages to keep (in days) separated by a comma
# Currently keeping weekly backups for 5 weeks and then two more 28 days apart (monthly)
ages="1,7,14,21,28,56,84"
```
## Kreativemedia
### python
On the MEOS Backups Server the administrator had Linux superuser access and could install any needed programs. At Kreativmedia the `ssh` access is a chrooted shell that is very limited in what the user can do. This situation is very unfriendly for a modern developer. Maybe a decade ago Kreativmedia chroot setup would have been considered on the cutting edge, but I digress.

`purgeFiles` needs python to run, but this is not installed on the Kreativmedia web hosting or if it is, it is not made available in the chrooted shell. A portable python was found and downloaded from [indygreg/python-build-standalone](https://github.com/indygreg/python-build-standalone) from the projects [releases page](https://github.com/indygreg/python-build-standalone/releases).

### cron and crontab (or lack thereof)
The chrooted shell at Kreativmedia is lacking the crontab program so editing cron jobs in the traditional way is not possible. Their Plesk control panel "Scheduled Tasks" offers very limited `cron` functionality. Mostly in that you can enter the job scheduling in a cron format.

Because the `crontab` command is unavailable it is not possible to set environment variables for the `cron` jobs, such as setting the $PATH or type of email to send, etc.