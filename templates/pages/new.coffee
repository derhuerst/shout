module.exports = ($) ->
	if $.success then return '
<h2>created <code>' + $.group.name + '</code></h2>

<p>You creared the group <code>' + $.group.name + '</code>. <strong>Please read the following instuctions carefully.</strong></p>

<p>Every group has a public and a private address. At the <em>public</em> address, interested people can subscribe to your group. Feel free to share it with everyone.</p>

<p>Your group\'s <em>public</em> address is <a href="/' + $.group.name + '"><code>' + $.site.url + '/' + $.group.name + '</code></a>.</p>

<p>At the <em>private</em> address, you can send messages to the group. Write this address down or bookmark it. And give it only to people who should be able to send messages!</p>

<p>Your group\'s <em>private</em> address is <a target="_blank" href="/' + $.group.name + '/' + $.group.key + '"><code>' + $.site.url + '/' + $.group.name + '/' + $.group.key + '</code></a>.</p>'

	else return '

<p>Pick a name for your group. Allowed characters are <code>A-Z</code>, <code>a-z</code>, <code>0-9</code> and <code>-</code>.</p>

<form action="/new" method="post">
	<input name="name" type="text" value="" placeholder="berlin-yoga-meetup" autocomplete="off">
	<input type="submit" value="create group">
</form>'
