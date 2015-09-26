boom =			require 'boom'

tpl =			require '../templates/pages/group-admin'
errorTpl =		require '../templates/pages/error'
mainTpl =		require '../templates/main'





module.exports = (req, reply) ->
	context =
		site:		@site
		group:
			name:	req.params.group
		notices:	[]
	orm = @orm

	orm.getGroup req.params.group
	.then (group) ->

		if group.key isnt req.params.key then return reply boom.forbidden "The key is incorrect."

		context.group = group
		context.group.name = req.params.group
		reply mainTpl context, tpl context

	.catch (err) -> reply err
