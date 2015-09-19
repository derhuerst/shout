tpl =			require '../templates/pages/group-lock'
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
			response = reply mainTpl contect, errorTpl context
			response.statusCode = 404
			return

		group = JSON.parse group
		if group.k isnt req.params.key
			context.error =
				short:		'wrong key'
				message:	"The key is incorrect."
			response = reply mainTpl contect, errorTpl context
			response.statusCode = 403
			return

		group.l = true
		context.group =
			name:	req.params.group
			key:	group.k
			locked:	true

		value = JSON.stringify group
		redis.set key, value, (err) ->
			if err
				context.error =
					short:		'internal error'
					message:	'An internal error occured.'
				response = reply mainTpl contect, errorTpl context
				response.statusCode = 500
				return

			reply mainTpl contect, tpl context
