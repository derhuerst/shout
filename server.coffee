Server =		require './src/Server'





server = Object.create Server
server.init '', '', 8000
server.start()
