boom =			require 'boom'

mainTpl =		require '../templates/main'
errorTpl =		require '../templates/pages/error'





module.exports = (req, reply) ->
	err = req.response
	return reply.continue() unless err instanceof Error

	console.error [
		err.output.statusCode
		if err.stack then err.stack else err.toString()
	].join ' '
	if err.isDeveloperError
		console.error 'isDeveloperError'
		err = boom.badImplementation()

	context =
		site:		@site
		notices:	[]
		error:		err
	response = reply mainTpl context, errorTpl context
	response.statusCode = err.output.statusCode
