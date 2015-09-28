uuid =			require 'uuid'
boom =			require 'boom'

tpl =			require '../templates/pages/new'
mainTpl =		require '../templates/main'





allowed = /^[A-Za-z0-9\-]{3,30}$/

notice = (context, reply, err) ->
	context.notices.push
		type:	'error'
		text:	err.message
	response = reply mainTpl context, tpl context
	response.statusCode = err.statusCode



module.exports = (req, reply) ->
	context =
		site:		@site
		group:		{}
		notices:	[]
	orm = @orm

	if not req.payload then return reply mainTpl context, tpl context

	if not allowed.test req.payload.name
		return notice context, reply, boom.badRequest 'The group name is either too long or has special characters. Only <code>A-Z</code>, <code>a-z</code>, <code>0-9</code> and <code>-</code> are allowed.'
	context.group.name = req.payload.name

	orm.groups.has req.payload.name
	.then (exists) ->
		if exists then return notice context, reply, boom.badRequest "The name <code>#{req.payload.name}</code> is already taken."

		context.group =
			name:	req.payload.name
			key:	uuid.v4()
			locked:	false

		orm.groups.add context.group.name, context.group.key, context.group.locked
		.then () ->
			context.success = true
			reply mainTpl context, tpl context

		.catch (err) -> throw err
	.catch (err) -> throw err
