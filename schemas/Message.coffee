mongoose =		require 'mongoose'
relationship =	require 'mongoose-relationship'





Message = new mongoose.Schema

	body:			String

	date:			Date

	group:
		type: mongoose.Schema.ObjectId
		ref: 'Group'
		childPath: 'messages'

Message.plugin relationship,
	relationshipPathName: 'group'



module.exports = Message
