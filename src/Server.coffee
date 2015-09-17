hapi =			require 'hapi'
vision =		require 'vision'
handlebars =	require 'handlebars'
path =			require 'path'
async =			require 'async'
mongoose =		require 'mongoose'

site =			require '../package.json'





module.exports =



	routes: [
		{
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



	init: (cert, key, port) ->
		if not cert? then throw new Error 'Missing `cert` argument.'
		if not key? then throw new Error 'Missing `key` argument.'
		if not port? then throw new Error 'Missing `port` argument.'

		@server = server = new hapi.Server()
		server.connection
			# tls:
			# 	cert:		cert
			# 	key:		key
			port:			port
		server.register vision, (err) ->
			if err then throw err
			server.views
				engines:
					hbs:		handlebars
				relativeTo:		path.join __dirname, '..'
				path:			'./templates'
				layout:			'default'
		server.bind this
		server.route @routes

		return this



	start: (cb = ()->) ->
		@server.start (err) ->
			if err then return cb err
			mongoose.connect 'mongodb://localhost/shout', (err) ->
				if err then return cb err
				cb()
		return this

	stop: (cb) ->
		@server.stop (err) ->
			if err then return cb err
			mongoose.disconnect 'mongodb://localhost/shout', (err) ->
				if err then return cb err
				cb()
		return this
