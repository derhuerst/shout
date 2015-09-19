module.exports = ($) ->
	if $.success then return '
<h2>created <code>' + $.group.name + '</code></h2>

<p>Your group has been created. You can see all messages at <a href="/' + $.group.name + '"><code>' + $.site.url + '/' + $.group.name + '</code></a>.</p>

<p>To send messages to your group, go to <a href="/' + $.group.name + '/' + $.group.key + '"><code>' + $.site.url + '/' + $.group.name + '/' + $.group.key + '</code></a>. Don\'t give anyone this link, as he could send any message to your subscribers!</p>'
	else return '

<p>Pick a name for your group. Allowed characters are <code>A-Z</code>, <code>a-z</code>, <code>0-9</code> and <code>-</code>.</p>

<form action="/new" method="post">
	<input name="name" type="text" value="" placeholder="berlin-yoga-meetup" autocomplete="off">
	<input type="submit" value="create group">
</form>'
