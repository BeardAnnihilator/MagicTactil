require './MagicTactilBDD.rb'

module ProfilesController

	# Action getu
	#
	# Get user information
	# === Parameters
	# * +username+ - (string)
	# === Surcess
	#   id\r1\nemail\rexample@gmail.com\nusername\rexample1\nname\rexample_name\ngivenname\rexameple_givenname\nbirthday\r18/07/1991\nlocation\rat home\ntelephone\r0102030405\ngender\rmale\nroomstatus\r1"
	# === Fail
	#   -Empty string-

	def getu(packet, params)
		user = User.find_by_username(params[:username])
		if (user.nil?)
			packet.data = ''
		else
			packet.data = "id\r#{user.id}\nemail\r#{user.email}\nusername\r#{user.username}\nname\r#{user.name}\ngivenname\r#{user.givenname}\nbirthday\r#{user.birthday}\nlocation\r#{user.location}\ntelephone\r#{user.telephone}\ngender\r#{user.gender}\nroomstatus\r#{user.roomstatus}"
		end
		packet
	end

	# Action setu
	#
	# Permit to change a personal information, player can only change their own informations
	# === Parameters
	# * +username+ - (string)
	# * +gender+ - (string)
	# * +email+ - (string)
	# * +location+ - (string)
	# * +password+ - (string)
	# * +telephone+ - (date)
	# === Success 
	#   OK
	# === Fail
	#   KO

	def setu(packet, params)
		user = User.find_by_username(params[:username])
		if (user.nil?)
			packet.data = 'KO'
		else
			# user.gender = params[:gender] if params[:gender] != nil
			# user.email = params[:email]	if params[:email] != nil
			# user.location = params[:location] if params[:location] != nil
			# user.password = params[:password] if params[:password] != nil
			# user.telephone = params[:telephone] if params[:telephone] != nil
			if (user.update_attributes(params.except(:client_name, :username)))
				packet.data = 'OK'
			else
				packet.data = 'KO'
			end
		end
		packet
	end
end