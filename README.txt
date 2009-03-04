EasyPush.rb is an easy to use Ruby sftp script.

Summary:
This script will compare all files in the local and remote directories based on modified time.  It will upload any new/modified files from the local to the remote directory.

Setup:
You must update the configuration at the top of the file prior to execution.
sftpServer = "ftp server name"
user = "sftp username"
password = "sftp password"
localDirectory = "/local/working/directory"
remoteDirectory = "/remote/working/directory"

Future Modifications:
- Recursively compare child directories.
- Accept optional parameters that will override configuration.
- Add help to script.