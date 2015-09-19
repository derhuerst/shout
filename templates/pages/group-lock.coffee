module.exports = ($) ->
	if $.group.locked then return '
<h2>locked <code>' + $.group.name + '</code></h2>

<p>From now on, nobody can send messages to <code>' + $.group.name + '</code> anymore.</p>'
	else return '
<h2><code>' + $.group.name + '</code></h2>

<form action="/' + $.group.name + '/' + $.group.key + '/lock" method="POST">
	<input class="red" type="submit" value="lock ' + $.group.name + '">
</form>'
