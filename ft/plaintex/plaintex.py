import sys
import socket

dataf = open(sys.argv[1], "r")
data = dataf.read()
dataf.close()

datasocket = socket.socket()
datasocket.connect((socket.gethostname(), int(sys.argv[2])))
datasocket.send(bytes(data, 'utf-8'))
datasocket.close()
