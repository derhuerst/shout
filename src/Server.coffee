hapi =			require 'hapi'
inert =			require 'inert'
path =			require 'path'
async =			require 'async'
redis =			require 'redis'

site =			require '../package.json'





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
			handler:	require './home.coffee'
		}, {
			path:		'/new'
			method:		[ 'GET', 'POST' ]
			handler:	require './new.coffee'
		}, {
			path:		'/{group}'
			method:		'GET'
			handler:	require './group.coffee'
		}, {
			path:		'/{group}/{key}'
			method:		'GET'
			handler:	require './group-admin.coffee'
		}, {
			path:		'/{group}/{key}/send'
			method:		[ 'GET', 'POST' ]
			handler:	require './group-send.coffee'
		}, {
			path:		'/{group}/{key}/lock'
			method:		[ 'GET', 'POST' ]
			handler:	require './group-lock.coffee'
		}
	],

	site:		site

	server:		null
	redis:		null



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
		server.register inert, (err) ->
			if err then throw err
		server.bind this
		server.route @routes

		@redis = redis.createClient()

		return this



	start: (cb = ()->) ->
		@server.start cb
		return this

	stop: (cb = ()->) ->
		@server.stop cb
		return this
