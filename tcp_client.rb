# simple TCP client
require 'socket'

port = 2000

s = TCPSocket.open("localhost", port)
while line = s.gets do puts "received : #{line.chop}" end
s.close