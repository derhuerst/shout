module.exports = ($) ->
	return '
<h2><i>shout</i> for everyone</h2>

<p>Keep up with things you are enthusiastic about. Participate when and where participation is needed.</p>

<p>Use <i>shout</i> to subscribe to groups you are interested. Receive notifications from their organizers, on your phone and in real time.</p>

<div class="grid">
	<div class="third first"><div class="box">
		<a class="button" href="#"><span class="i i-apple"></span> App Store</a>
	</div></div>
	<div class="third"><div class="box">
		<a class="button disabled" href="#"><span class="i i-android"></span> Play Store</a>
	</div></div>
	<div class="third last"><div class="box">
		<a class="button disabled" href="#"><span class="i i-windows"></span> Windows Store</a>
	</div></div>
</div>

<p>Featured groups:
	<a href="' + $.site.url + '/bln-refugees-help"><code>bln-refugees-help</code></a>,
	<a href="' + $.site.url + '/festivals-germany"><code>festivals-germany</code></a>
</p>

<h2><i>shout</i> for organizers</h2>

<p>Inform and coordinate people immediatly. Reach and motivate others enthusiastic about what you care about.</p>

<a class="button" href="/new">create a group</a>'
