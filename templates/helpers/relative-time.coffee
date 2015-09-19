moment =		require 'moment'






moment.locale 'relative-time',
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



module.exports = (date) ->
	now = moment()
	date = moment(date).locale 'relative-time'
	return '<time date="' + date.toISOString() + '">' + date.from now + '</time>'
