uuid =			require 'uuid'

Group =			require '../models/Group'





allowed = /[A-Za-z0-9\-]{3,50}/

onError = (context, reply, text, code) ->
	context.notices.push
		type:	'error'
		text:	text
	response = reply.view 'pages/new', context
	response.statusCode = code



module.exports = (req, reply) ->
	context =
		site:		@site
		page:		{}
		req:		req
		notices:	[]

	if not req.payload
		reply.view 'pages/new', context
		return

	if not allowed.test req.payload.name
		return onError context, reply, 'The group name is either too long or has special characters. Only <code>A-Z</code>, <code>a-z</code>, <code>0-9</code> and <code>-</code> are allowed.', 400

	Group.count
		name:	req.payload.name
	.then (count) ->
		if count > 0 then return onError context, reply, "The name <code>#{req.payload.name}</code> is already taken.", 400

		group = new Group
		 	name:	req.payload.name
		 	key:	uuid.v4()
		 	locked:	false
		group.save (err) ->
			if err then return onError context, reply, 'An internal error occured.', 500

			context.success = true
			context.group = group
			reply.view 'pages/new', context

	.catch (err) ->
		return onError context, reply, 'An internal error occured.', 500
