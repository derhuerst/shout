module.exports = ($) ->
	return '
<h2>' + ($.error?.error or 'Unknown Error') + '</h2>

<p>' + $.error?.message + '</p>'
