module.exports = ($) ->
	out = '
<h2><code>' + $.group.name + '</code></h2>'
	if $.group.locked then out += '
<p>This group is locked.</p>'
	else out += '
<form action="/' + $.group.name + '/' + $.group.key + '/send" method="POST">
	<input name="body" type="text" value="" placeholder="a short and helpful message">
	<input type="submit" value="send">
</form>

<hr>

<p>You can lock this group in case of abuse. <strong>This can\'t be undone.</strong></p>

<form action="/' + $.group.name + '/' + $.group.key + '/lock" method="POST">
	<input class="red" type="submit" value="lock ' + $.group.name + '">
</form>'
	return out
