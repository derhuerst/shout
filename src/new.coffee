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
	orm = @orm

	if not req.payload
		reply mainTpl context, tpl context
		return

	if not allowed.test req.payload.name
		return onError context, reply, 'The group name is either too long or has special characters. Only <code>A-Z</code>, <code>a-z</code>, <code>0-9</code> and <code>-</code> are allowed.', 400
	context.group.name = req.payload.name

	orm.groupExists req.payload.name
	.then (groupExists) ->
		if groupExists then return onError context, reply, "The name <code>#{req.payload.name}</code> is already taken.", 400

		context.group =
			name:	req.payload.name
			key:	uuid.v4()
			locked:	false

		orm.setGroup context.group.name,
			key:	context.group.key
			locked:	context.group.locked
		.then () ->
			context.success = true
			reply mainTpl context, tpl context
		.catch (err) -> onError context, reply, 'An internal error occured.', 500

	.catch (err) -> onError context, reply, 'An internal error occured.', 500
