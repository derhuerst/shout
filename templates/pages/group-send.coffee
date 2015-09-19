module.exports = ($) ->
	if $.success then return '
<h2>message sent</h2>

<p>Your message has been sent to <a href="/' + group.name + '"><code>' + group.name + '</code></a>.</p>'
	else return '
<h2><code>' + $.group.name + '</code></h2>

<form action="/' + $.group.name + '/' + $.group.key + '/send" method="POST">
	<input name="body" type="text" value="" placeholder="a short and helpful message">
	<input type="submit" value="send">
</form>'
