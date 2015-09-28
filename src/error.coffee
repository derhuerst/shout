boom =			require 'boom'

mainTpl =		require '../templates/main'
errorTpl =		require '../templates/pages/error'





module.exports = (req, reply) ->
	err = req.response
	return reply.continue() unless err instanceof Error
	if not err.isBoom then err = boom.wrap err, err.statusCode

	console.error [
		err.output.statusCode
		if err.stack then err.stack else err.toString()
	].join ' '
	if err.isDeveloperError then err = boom.badImplementation()

	context =
		site:		@site
		notices:	[]
		error:		err.output.payload
	err.output.payload = mainTpl context, errorTpl context
	reply err
