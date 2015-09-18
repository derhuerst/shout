Group =			require '../models/Group'
Message =		require '../models/Message'





onError = (context, reply, text, code) ->
	context.notices.push
		type:	'error'
		text:	text
	response = reply.view "pages/group", context
	response.statusCode = code



module.exports = (req, reply) ->
	context =
		site:		@site
		page:		{}
		req:		req
		notices:	[]

	Group.findOne
		name:	req.params.group
	.then (group) ->
		if not group
			context.error =
				short:		'not found'
				message:	"There is no group <code>#{req.params.group}</code>."
			response = reply.view 'pages/error', context
			response.statusCode = 404
			return

		Message.find
			group:	group
		.limit 30
		.exec (err, messages) ->
			if err then return onError context, reply, 'An internal error occured.', 500

			context.messages = []
			for message in messages
				context.messages.push
					body:	message.body
					date:	message.date
			context.group = group
			reply.view 'pages/group', context

	.catch (err) ->
		return onError context, reply, 'An internal error occured.', 500
