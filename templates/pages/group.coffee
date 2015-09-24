relativeTime =		require '../helpers/relative-time'





module.exports = ($) ->
	out = '
<h2><code>' + $.group?.name + '</code></h2>
<a class="button" href="#"><span class="i i-subscribe"></span> subscribe to this group</a>'
	if $.messages and $.messages.length > 0
		out += '
<ul id="messages">'
		for message in $.messages
			out += '
	<li class="message box">' + relativeTime(message.date) + '<p>' + message.body + '</p></li>'
	else out += '
<p>There are no messages here yet.</p>'
	return out
