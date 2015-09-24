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
	orm = @orm

	orm.getGroup req.params.group
	.then (group) ->

		if not group
			context.error =
				short:		'not found'
				message:	"There is no group <code>#{req.params.group}</code>."
			response = reply mainTpl context, errorTpl context
			response.statusCode = 404
			return

		context.group = group
		context.group.name = req.params.group
			context.messages = []

		orm.getMessagesOfGroup req.params.group
		.then (messages) ->
			context.messages = messages
			reply mainTpl context, tpl context

		.catch (err) -> onError context, reply, 'An internal error occured.', 500

	.catch (err) -> onError context, reply, 'An internal error occured.', 500
