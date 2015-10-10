hapi =			require 'hapi'
inert =			require 'inert'
path =			require 'path'
http =			require 'http'
ccount =		require 'callback-count'

orm =			require 'shout-orm'
site =			require '../package.json'
error =			require './error'
redirectHttp =	require './redirect-http'

pages =
	home:		require './pages/home'
	new:		require './pages/new'
	group:		require './pages/group'
	admin:		require './pages/group-admin'
	send:		require './pages/group-send'
	lock:		require './pages/group-lock'





module.exports =



	routes: [
		{
			path:		'/assets/{path*}'
			method:		'GET'
			handler:
				directory:
					path: 'assets'
					listing: false
					index: true
		}, {
			path:		'/'
			method:		'GET'
			handler:	pages.home
		}, {
			path:		'/new'
			method:		[ 'GET', 'POST' ]
			handler:	pages.new
		}, {
			path:		'/{group}'
			method:		'GET'
			handler:	pages.group
		}, {
			path:		'/{group}/{key}'
			method:		'GET'
			handler:	pages.admin
		}, {
			path:		'/{group}/{key}/send'
			method:		[ 'GET', 'POST' ]
			handler:	pages.send
		}, {
			path:		'/{group}/{key}/lock'
			method:		[ 'GET', 'POST' ]
			handler:	pages.lock
		}
	],

	site:		site

	server:		null
	httpServer:	null
	orm:		orm



	init: (cert, key, port, httpPort) ->
		if not cert? then throw new Error 'Missing `cert` argument.'
		if not key? then throw new Error 'Missing `key` argument.'
		if not port? then throw new Error 'Missing `port` argument.'

		@server = server = new hapi.Server()
		server.connection
			tls:
			 	cert:			cert
			 	key:			key
			port:				port
			routes:
				files:
					relativeTo:	path.join __dirname, '..'
		server.bind this
		server.register inert, (err) ->
			if err then throw err
		server.ext 'onPreResponse', error
		server.route @routes

		@httpServer = http.createServer redirectHttp port
		@httpServer.port = httpPort

		@orm.connect()

		return this



	start: (cb = ()->) ->
		tasks = ccount 2, cb
		@server.start tasks.next
		@httpServer.listen @httpServer.port, tasks.next
		return this

	stop: (cb = ()->) ->
		tasks = ccount 2, cb
		@server.stop tasks.next
		@httpServer.close tasks.next
		return this
