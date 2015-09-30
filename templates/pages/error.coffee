module.exports = ($) ->
	return '
<h2>' + ($.error?.error or 'Unknown Error') + '</h2>


<div id="notices">
	<p class="notice error">' + $.error?.message + '</p>
</div>'
