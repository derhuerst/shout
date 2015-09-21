uuid =			require 'uuid'

tpl =			require '../templates/pages/new'
mainTpl =		require '../templates/main'





allowed = /^[A-Za-z0-9\-]{3,30}$/

onError = (context, reply, text, code) ->
	context.notices.push
		type:	'error'
		text:	text
	response = reply mainTpl context, tpl context
	response.statusCode = code



module.exports = (req, reply) ->
	context =
		site:		@site
		group:		{}
		notices:	[]
	redis = @redis

	if not req.payload
		reply mainTpl context, tpl context
		return

	if not allowed.test req.payload.name
		return onError context, reply, 'The group name is either too long or has special characters. Only <code>A-Z</code>, <code>a-z</code>, <code>0-9</code> and <code>-</code> are allowed.', 400
	context.group.name = req.payload.name

	key = 'g:' + req.payload.name   # `g` for groups
	redis.get key, (err, result) ->
		if err then return onError context, reply, 'An internal error occured.', 500

		if result then return onError context, reply, "The name <code>#{req.payload.name}</code> is already taken.", 400

		context.group =
			name:	req.payload.name
			key:	uuid.v4()
			locked:	false

		value = JSON.stringify
			k:		context.group.key
			l:		context.group.locked
		redis.set key, value, (err) ->
			if err then return onError context, reply, 'An internal error occured.', 500

			context.success = true
			reply mainTpl context, tpl context
