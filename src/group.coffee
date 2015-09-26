async =			require 'async'
boom =			require 'boom'

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
	orm = @orm

	orm.getGroup req.params.group
	.then (group) ->

		context.group = group
		context.group.name = req.params.group
		context.messages = []

		orm.getMessagesOfGroup req.params.group
		.then (messages) ->
			context.messages = messages
			reply mainTpl context, tpl context

		.catch (err) -> reply err
	.catch (err) -> reply err
