hapi =			require 'hapi'
inert =			require 'inert'
path =			require 'path'
async =			require 'async'

orm =			require 'shout-orm'
site =			require '../package.json'
error =			require './error'

api =
	register:	require './api/register'
	activate:	require './api/activate'

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
			path:		'/register'
			method:		[ 'POST' ]
			handler:	api.register
		}, {
			path:		'/activate'
			method:		[ 'POST' ]
			handler:	api.activate
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
	orm:		orm



	init: (cert, key, port) ->
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

		@orm.connect()

		return this



	start: (cb = ()->) ->
		@server.start cb
		return this

	stop: (cb = ()->) ->
		@server.stop cb
		return this
