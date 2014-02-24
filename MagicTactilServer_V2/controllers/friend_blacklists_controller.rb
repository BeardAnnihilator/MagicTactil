require './MagicTactilBDD.rb'

module FriendBlacklistsController

	# Action adfr
	#
	# Add friend to friend list
	# === Parameters
	# * +username+ - (string)
	# * +belongsto+ - (string) - The username parameters belongsto to the user who sent the request
	# === Success
	#   OK
	# === Fail
	#   KO

	def adfr(packet, params)
		packet.data = 'KO'
		if (User.where('username=? OR username=?', params[:username], params[:belongsto]).count == 2)
			if (Friendblacklist.where('belongsto=? AND username=? AND typelist="F"',
				params[:belongsto], params[:username]).empty?)
				Friendblacklist.create(params.merge(typelist: 'F').except(:client_name))
				packet.data = 'OK'; return (packet)
			end
		end
		log_error('[adfr]    user(s) doesn\'t exist or friendship already exists :)')
		packet
	end

	# Action delf
	#
	# Delete friend
	# === Parameters
	# * +username+ - (string)
	# * +belongsto+ - (string) - The username parameters belongsto to the user who sent the request
	# === Success
	#   OK
	# === Fail
	#   KO

	def delf(packet, params)
		packet.data = 'KO'
		if (User.where('username=? OR username=?', params[:username], params[:belongsto]).count == 2)
			f = Friendblacklist.where('belongsto=? AND username=?',
					params[:belongsto], params[:username])
			unless (f.empty?)
				f.first.delete
				packet.data = 'OK'; return (packet)
			end
		end
		log_error('[delf]    user(s) doesn\'t exist or friendship already exists :)')
		packet
	end

	# Action adbl
	#
	# Add player to black list
	# === Parameters
	# * +username+ - (string)
	# * +belongsto+ - (string) - The username parameters belongsto to the user who sent the request
	# === Success
	#   OK
	# === Fail
	#   KO

	def adbl(packet, params)
		packet.data = 'KO'
		if (User.where('username=? OR username=?', params[:username], params[:belongsto]).count == 2)
			if (Friendblacklist.where('belongsto=? AND username=? AND typelist="B"',
				params[:belongsto], params[:username]).empty?)
				Friendblacklist.create(params.merge(typelist: 'B').except(:client_name))
				packet.data = 'OK'; return (packet)
			end
		end
		log_error('[adbl]    user(s) doesn\'t exist or friendship already exists :)')
		packet
	end

	# Action debl
	#
	# Delete player from a blacklist
	# === Parameters
	# * +username+ - (string)
	# * +belongsto+ - (string) - The username parameters belongsto to the user who sent the request
	# === Success
	#   OK
	# === Fail
	#   KO

	def debl(packet, params)
		packet.data = 'KO'
		if (User.where('username=? OR username=?', params[:username], params[:belongsto]).count == 2)
			f = Friendblacklist.where('belongsto=? AND username=?',
					params[:belongsto], params[:username])
			unless (f.empty?)
				f.first.delete
				packet.data = 'OK'; return (packet)
			end
		end
		log_error('[debl]    user(s) doesn\'t exist or friendship already exists :)')
		packet
	end

	# Action gfrl
	#
	# Get player friendlist
	# === Parameters
	# * +username+ - (string)
	# === Success
	#   friend1\nfriend2\nfriend3\n
	# === Fail
	#   -Empty string-

	def gfrl(packet, params)
    packet.data = ""
		friendlist = Friendblacklist.where('typelist = "F" AND username = ? ', params[:username])
		friendlist.each do |item|
			packet.data += "#{item.belongsto}\n" 
		end
		packet
	end

	# Action gtbl
	#
	# Get player blacklist
	# === Parameters
	# * +username+ - (string)
	# === Success
	#   notFriend1\nnotFriend2\nnotFriend3\n
	# === Fail
	#   -Empty string-


	def gtbl(packet, params)
 		packet.data = ""
		blacklist = Friendblacklist.where('typelist = "B" AND username = ? ', params[:username])
		blacklist.each do | item|
			packet.data += "#{item.belongsto}\n"
		end
		packet
	end
end