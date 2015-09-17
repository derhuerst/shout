mongoose =		require 'mongoose'

Message =		require	'../schemas/Message'





module.exports = mongoose.model 'Message', Message
