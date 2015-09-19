relativeTime =		require '../helpers/relative-time'





module.exports = ($) ->
	out = '
<h2><code>' + $.group?.name + '</code></h2>'
	if $.messages
		out += '
<ul id="messages">'
		for message in $.messages
			out += '
	<li class="message box">' + relativeTime(message.date) + '<p>' + message.body + '</p></li>'
	else out += '
<p>There are no messages here yet.</p>'
	return out
