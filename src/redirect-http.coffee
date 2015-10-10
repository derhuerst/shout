url =			require 'url'





module.exports = (port) ->
	return (req, res) ->
		target = url.parse 'http://' + req.headers.host + req.url
		target.protocol = 'https'
		target.port = port
		delete target.host
		target = url.format target

		res.statusCode = '301'
		res.setHeader 'Location', target
		res.end 'Redirecting to ' + target
