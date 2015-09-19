module.exports = ($) ->
	return '
<h2>' + ($.err.short or 'error') + '</h2>

<p>' + $.err.message + '</p>'
