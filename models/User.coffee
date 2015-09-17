mongoose =		require 'mongoose'

User =			require	'../schemas/User'





module.exports = mongoose.model 'User', User
