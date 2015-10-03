boom =			require 'boom'





module.exports = (req, reply) ->
	if not req.payload.system then return reply boom.badRequest 'Missing `system` parameter.'
	if not req.payload.token then return reply boom.badRequest 'Missing `token` parameter.'

	orm.registrations.activate shortHash(req.payload.token), req.payload.system, req.payload.token
	.then () ->
		reply { success: 'ok' }

	.catch (err) ->
		reply
			status:		'error'
			error:		err
