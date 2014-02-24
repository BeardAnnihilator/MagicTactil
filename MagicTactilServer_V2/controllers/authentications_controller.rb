#$LOAD_PATH << '~/Desktop/EIP/'
require './MagicTactilBDD.rb'

module	AuthenticationsController

  # ACTION regu
  #
  # Register the user into the database
  # === Parameters
  # * +username+ - (string)
  # * +email+ - (string)
  # * +password+ - (string)
  # === Success
  #   OK
  # === Fail
  #   KO
  #
  
	def regu(packet, params)
		if User.find_by_username(params[:username]) || User.find_by_email(params[:email])
			packet.data = "KO"
		else
			user = User.new(params)
			user.state = 'N'
			if user.save
				packet.data =  "OK"
			else
        packet.data = "KO"
				log_error('[regu]  ' + user.errors.messages.to_s)
			end
		end
		packet
	end

  # ACTION sgni
  #
  # Permit the user to sign in
  # === Parameters
  # * +username+ - (string)
  # * +password+ - (string)
  # === Success
  #   OK
  # === Fail
  #   KO
  #
	
	def sgni(packet, params)

		if user = User.find_by_username_and_password(params[:username], params[:password])
			packet.data = 'OK'
		else
			packet.data = 'KO' 
			log_error('[sgni]  params = ' + params[:username])
		end
		packet
	end

  # ACTION sgno
  #
  # Permit the user to sign out
  # === Parameters
  # * +username+ - (string)
  # === Success
  #   OK
  # === Fail
  #   KO
  #
	def sgno(packet, params)
		if user = User.find_by_username(params[:username])
			packet.data = 'OK'
		else
			packet.data = 'KO'
		end
		packet
	end
end