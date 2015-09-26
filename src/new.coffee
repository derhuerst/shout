uuid =			require 'uuid'

tpl =			require '../templates/pages/new'
mainTpl =		require '../templates/main'





allowed = /^[A-Za-z0-9\-]{3,30}$/

module.exports = (req, reply) ->
	context =
		site:		@site
		group:		{}
		notices:	[]
	orm = @orm

	if not req.payload then return reply mainTpl context, tpl context

	if not allowed.test req.payload.name
		context.notices.push
			type:	'error'
			text:	'The group name is either too long or has special characters. Only <code>A-Z</code>, <code>a-z</code>, <code>0-9</code> and <code>-</code> are allowed.'
		response = reply mainTpl context, tpl context
		response.statusCode = 400
		return

	context.group.name = req.payload.name

	orm.groupExists req.payload.name
	.then (groupExists) ->
		if groupExists
			context.notices.push
				type:	'error'
				text:	"The name <code>#{req.payload.name}</code> is already taken."
			response = reply mainTpl context, tpl context
			response.statusCode = 400
			return

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
		.catch (err) -> reply err

	.catch (err) -> reply err
