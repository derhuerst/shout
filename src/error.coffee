boom =			require 'boom'

mainTpl =		require '../templates/main'
errorTpl =		require '../templates/pages/error'





module.exports = (req, reply) ->
	err = req.response
	return reply.continue() unless err instanceof Error
	if not err.isBoom then err = boom.wrap err, err.statusCode

	console.error [
		err.output.statusCode
		req.method.toUpperCase()
		req.path
	].join '\t'
	if err.isDeveloperError then console.error err.stack

	# show a different version to the user
	if err.isDeveloperError then err = boom.badImplementation()
	context =
		site:		@site
		notices:	[]
		error:		err.output.payload
	response = reply mainTpl context, errorTpl context
	response.statusCode = err.statusCode
