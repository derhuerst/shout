Group =			require '../models/Group'
Message =		require '../models/Message'





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

		if group.key isnt req.params.key
			context.error =
				short:		'wrong key'
				message:	"The key is incorrect."
			response = reply.view 'pages/error', context
			response.statusCode = 403
			return

		context.group = group
		message = new Message
		 	body:	req.payload.body
		 	date:	new Date()
		 	group:	group
		message.save (err) ->
			if err
				context.error =
					short:		'internal error'
					message:	'An internal error occured.'
				response = reply.view 'pages/error', context
				response.statusCode = 500
				return

			context.success = true
			reply.view 'pages/group-send', context

	.catch (err) ->
		console.log 'error', err
		reply err
