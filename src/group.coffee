async =			require 'async'

tpl =			require '../templates/pages/group'
errorTpl =		require '../templates/pages/error'
mainTpl =		require '../templates/main'




onError = (context, reply, text, code) ->
	context.notices.push
		type:	'error'
		text:	text
	response = reply mainTpl context, tpl context
	response.statusCode = code



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
			response = reply mainTpl context, errorTpl context
			response.statusCode = 404
			return

		group = JSON.parse group
		context.group =
			name:	req.params.group
			key:	group.k
			locked:	group.l

		# todo: find a way to stream keys for performance
		pattern = 'm:' + req.params.group + ':*'   # `m` for messages
		redis.keys pattern, (err, keys) ->
			if err then return onError context, reply, 'An internal error occured.', 500

			context.messages = []
			async.eachLimit keys, 50, ((key, cb) ->
				# todo: use [redis transactions](http://redis.io/topics/transactions) or at least [redis pipelining](http://redis.io/topics/pipelining)
				redis.get key, (err, message) ->
					message = JSON.parse message
					context.messages.push
						date:	new Date message.d
						body:	message.b
					cb()
			), () ->
				if context.messages.length is 0
					context.messages = null
				reply mainTpl context, tpl context
