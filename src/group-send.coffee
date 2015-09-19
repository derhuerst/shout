shortid =		require 'shortid'





module.exports = (req, reply) ->
	context =
		site:		@site
		group:
			name:	req.params.group
		notices:	[]
	redis = @redis

	key = 'g:' + req.params.group   # `g` for groups
	redis.get key, (err, group) ->
		if err then return onError context, reply, 'An internal error occured.', 500

		if not group
			context.error =
				short:		'not found'
				message:	"There is no group <code>#{req.params.group}</code>."
			response = reply.view 'pages/error', context
			response.statusCode = 404
			return

		group = JSON.parse group
		if group.k isnt req.params.key
			context.error =
				short:		'wrong key'
				message:	"The key is incorrect."
			response = reply.view 'pages/error', context
			response.statusCode = 403
			return

		context.group =
			name:	req.params.group
			key:	group.k
			locked:	group.l

		key = 'm:' + req.params.group + ':' + shortid.generate()   # `m` for messages
		value = JSON.stringify
		 	d:	new Date().valueOf()
		 	b:	req.payload.body
		redis.set key, value, (err) ->
			if err
				context.error =
					short:		'internal error'
					message:	'An internal error occured.'
				response = reply.view 'pages/error', context
				response.statusCode = 500
				return

			context.success = true
			reply.view 'pages/group-send', context
