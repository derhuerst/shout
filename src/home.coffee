module.exports = (req, reply) ->
	context =
		site:		@site
		page:		{}

	reply.view 'pages/home', context
