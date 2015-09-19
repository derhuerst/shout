tpl =			require '../templates/pages/home'
mainTpl =		require '../templates/main'





module.exports = (req, reply) ->
	context =
		site:		@site

	response = reply mainTpl context, tpl context
