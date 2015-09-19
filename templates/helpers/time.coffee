handlebars =	require 'handlebars'
moment =		require 'moment'






moment.locale 'shout',
	relativeTime:
		future:	'in %s'
		past:	'%s ago'
		s:		'%ds'
		m:		'1m'
		mm:		'%dm'
		h:		'1h'
		hh:		'%dh'
		d:		'1d'
		dd:		'%dd'
		M:		'1M'
		MM:		'%dM'
		y:		'1y'
		yy:		'%dy'
moment.locale 'en'   # todo: fix this. ugly fix because setting a locale locally without messing up the global seems impossible



module.exports = (options, context) ->
	now = moment()
	date = moment(options).locale 'shout'
	return new handlebars.SafeString [
		'<time date="'
		date.toISOString()
		'">'
		date.from now
		'</time>'
	].join ''
