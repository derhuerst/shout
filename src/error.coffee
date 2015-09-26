boom =			require 'boom'

mainTpl =		require '../templates/main'
errorTpl =		require '../templates/pages/error'





module.exports = (req, reply) ->
	err = req.response
	return reply.continue() unless err instanceof Error
	if not err.isBoom then err = boom.wrap err, err.statusCode

	if err.output?.statusCode
		console.error err.output.statusCode, err.toString()
	else console.error err.toString()

	context =
		site:		@site
		notices:	[]
		error:		err.output.payload
	err.output.payload = mainTpl context, errorTpl context
	reply err
