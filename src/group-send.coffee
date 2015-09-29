shortid =		require 'shortid'
boom =			require 'boom'

tpl =			require '../templates/pages/group-send'
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
		if group.key isnt req.params.key then return reply boom.forbidden "The key is incorrect."

		context.group = group
		context.group.name = req.params.group

		messageId = shortid.generate()
		orm.messages.add req.params.group, messageId, req.payload.body, new Date().valueOf()   # todo: escape html
		.then () ->
			context.success = true
			reply mainTpl context, tpl context

		.catch (err) -> throw err
	.catch (err) -> throw err
