async =			require 'async'
boom =			require 'boom'

tpl =			require '../templates/pages/group'
errorTpl =		require '../templates/pages/error'
mainTpl =		require '../templates/main'





module.exports = (req, reply) ->
	context =
		site:		@site
		group:
			name:	req.params.group
		notices:	[]
	orm = @orm

	orm.groups.get req.params.group
	.then (group) ->

		if not group then return reply boom.notFound "There is no group <code>#{req.params.group}</code>."

		context.group = group
		context.group.name = req.params.group
		context.messages = []

		orm.messages.all req.params.group
		.then (messages) ->
			context.messages = messages
			reply mainTpl context, tpl context

		.catch (err) -> reply err
	.catch (err) -> reply err
