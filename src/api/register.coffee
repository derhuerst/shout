boom =			require 'boom'
shortHash =		require 'short-hash'





module.exports = (req, reply) ->
	if not req.payload.token then return reply boom.badRequest 'Missing `token` parameter.'

	orm.registrations.add shortHash(req.payload.token), req.payload.token
	.then () ->
		repl { success: 'ok' }

	.catch (err) ->
		reply
			status:		'error'
			error:		err
