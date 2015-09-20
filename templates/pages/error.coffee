module.exports = ($) ->
	return '
<h2>' + ($.error?.short or 'error') + '</h2>

<p>' + $.error.message + '</p>'
