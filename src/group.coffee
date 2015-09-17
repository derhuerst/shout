Group =			require '../models/Group'





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

		context.group = group
		reply.view 'pages/group', context

	.catch (err) ->
		console.log 'error', err
		reply err
