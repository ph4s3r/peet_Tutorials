require 'socket'

myPort = 2000,
    fileToOpen
    #server sends client file over socket

    server = TCPServer.open(myPort)

    loop {
      Thread.start(server.accept) do |client|
        #client.puts(Time.now.ctime)
        file = open(fileToOpen, "rb")
        fileContent = file.read
        client.puts(fileContent)
        client.close
      end

    }

