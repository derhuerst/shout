handlebars =	require 'handlebars'
moment =		require 'moment'





module.exports = (options, context) ->
	return new handlebars.SafeString [
		'<time date="'
		moment(options).toISOString()
		'">'
		moment(options).fromNow()
		'</time>'
	].join ''
