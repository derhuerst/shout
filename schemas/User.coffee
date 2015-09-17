mongoose =		require 'mongoose'
relationship =	require 'mongoose-relationship'





User = new mongoose.Schema

	id:				String

	groups: [ {
		type: mongoose.Schema.ObjectId
		ref: 'Group'
		childPath: 'users'
	} ]

User.plugin relationship,
	relationshipPathName: 'groups'



module.exports = User
