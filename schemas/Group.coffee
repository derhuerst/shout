mongoose =		require 'mongoose'

User =			require './User'
Message =		require './Message'





Group = new mongoose.Schema

	# This is the public name of the group.
	name:			String   # /[a-z0-9\-]{3,50}/
	# This key can be used to send new messages and lock the group.
	key:			String   # auto-generated; /[A-Za-z0-9]{64}/
	locked:			Boolean

	users:			[ { type: mongoose.Schema.ObjectId, ref: 'User' } ]

	messages:		[ { type: mongoose.Schema.ObjectId, ref: 'Message' } ]



module.exports = Group
