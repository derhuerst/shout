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
	ormd = @orm

	orm.getGroup req.params.group
	.then (group) ->

		if group.key isnt req.params.key then return reply boom.forbidden "The key is incorrect."

		context.group = group
		context.group.name = req.params.group

		messageId = shortid.generate()
		orm.setMessage req.params.group, messageId, new Date().valueOf(), req.payload.body   # todo: escape html

		.then () ->
			context.success = true
			reply mainTpl context, tpl context

		.catch (err) -> reply err
	.catch (err) -> reply err
