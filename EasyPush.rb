require 'rubygems'
require 'net/sftp'

# Configuration - Begin
sftpServer = "ftp server name"
user = "sftp username"
password = "sftp password"
localDirectory = "/local/working/directory"
remoteDirectory = "/remote/working/directory"
# Configuration - End

Net::SFTP.start(sftpServer, user, :password=>password) do |sftp|
   Dir.chdir(localDirectory)
   Dir.foreach(".") do |fileName|
      if fileName.index('.').nil? or fileName.index('.') > 0
         puts "Comparing " + fileName
         if File.directory?(fileName)
            puts "TODO: This is a directory.  Go into it.  Check child directories and files."
         else
            begin
               file = sftp.file.open(remoteDirectory + "/" + fileName)
               if File.lstat(fileName).mtime > Time.at(file.stat().mtime)
                  puts "File found.  Upload updated file."
                  sftp.upload(localDirectory + "/" + fileName, remoteDirectory + "/" + fileName)
               else
                  puts "File has not changed."
               end
            rescue Net::SFTP::StatusException
               puts "File not found.  Uploading new file."
               sftp.upload(localDirectory + "/" + fileName, remoteDirectory + "/" + fileName)
            end
         end
      else
         puts "Do not compare " + fileName
      end
      puts # print blank line
   end  
end
