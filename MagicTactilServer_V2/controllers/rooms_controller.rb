require './MagicTactilBDD.rb'
require './helpers/room_helper.rb'

module RoomsController

	# Action cnro
	#
	# Create room
	# === Parameters
	# * +nameRoom+ - (string)
	# * +nameOwner+ - (string)
	# * +format+ - (string) - Which type of game do you want to play. For MTGC, it could be Standard, Vintage, etc
	# * +nameRoom+ - (string)
	# * +state+ - (integer) - If it's visible or not
	# === Success
	#   1 - this number is the id's room you have just created
	# === Fail
	#   KO

	def cnro(packet, params)
		if (!params[:nameRoom] || !params[:nameOwner] || !params[:format] ||
				!params[:state])
					packet.data = "KO"
				log_error("[cnro]  one of parameters is missing(nameOwner, nameRoom, format, state)")
		else
			if Room.find_by_nameRoom(params[:nameRoom]) || (params[:state].to_i > 1 || params[:state].to_i < 0) 
				packet.data = "KO"
				log_error("[cnro]  room #{params[:nameRoom]} already exist or state (#{params[:state]}) is not good")
			else
				room = Room.new(params.except(:client_name))
				# room.nameOwner = params[:nameOwner]
				# room.format = params[:format]
				# room.nameRoom = params[:nameRoom]
				# room.state = params[:state]
				room.maxSize = 2
				room.nbPlayer = 0
				if room.save!
					if user = User.find_by_username(params[:nameOwner])
						roomplayer = Roomplayer.new({:idRoom => room.id, :idUser => user.id})
						# roomplayer.idRoom = room.id
						# roomplayer.idUser = user.id
						room.nbPlayer = room.nbPlayer + 1;
						if roomplayer.save
							packet.data = room.id.to_s
						else
							packet.data = 'KO'
							log_error("[cnro]  " + roomplayer.errors.messages)
						end
					else
						packet.data = 'KO'
						log_error("[cnro]  user #{params[:nameOwner]}")
					end
				else
					packet.data = 'KO'
					log_error("[cnro]  " + room.errors.messages)
				end
			end
		end
		packet
	end

	# Action dero
	#
	# Delete room
	# === Parameters
	# * +nameOwner+ - (string)
	# * +nameRoom+ - (string)
	# === Success
	#   OK
	# === Fail
	#   KO

	def dero(packet, params)
		#room = Room.find_by_id(params[:id])
		users = User.find_by_username(params[:nameOwner])
		room = Room.find_by_nameRoom(params[:nameRoom])
		if users.nil? || room.nil?
			packet.data = "KO"
			log_error("[dero]  one of the parameters is missing or doesn't exist (user =>  [#{params[:nameOwner]}] and room => [#{params[:nameRoom]}])")
		else
			roomplayer = Roomplayer.find_by_idUser_and_idRoom(users.id, room.id)
			if roomplayer.nil?
				packet.data = "KO"
				log_error("[dero]  user #{params[:nameOwner]} in not the owner of the room #{params[:nameRoom]}")
			else
				params[:function] = "KILR"
				params["client_name".to_sym] = params[:nameOwner]
				params[:data] = "OK"
				communication.notif(params)
				clean_depth(room)
				packet.data = "OK"
			end
		end
		packet
	end

	# Action joro
	#
	# Join room
	# === Parameters
	# * +username+ - (string)
	# * +nameRoom+ - (string)
	# * +client_name+ - (string) - Same as username, this is used by communication to make the notification module working
	# === Success
	#   OK
	# === Fail
	#   KO

	def joro(packet, params)
		if params[:username] && params[:nameRoom]
			user = User.find_by_username(params[:username])
			room = Room.find_by_nameRoom(params[:nameRoom])
			if (room.nil? || user.nil?) || (Roomplayer.find_by_idUser_and_idRoom(user.id, room.id)) || (room.nbPlayer >= room.maxSize)
				packet.data = "KO"
				log_error("[joro]  user #{params[:username]} already in room #{params[:nameRoom]}")
			else
				roomplayer = Roomplayer.new({:idRoom => room.id, :idUser => user.id})
				# roomplayer.idRoom = room.id
				# roomplayer.idUser = user.id
				room.nbPlayer = room.nbPlayer + 1;
				if room.save
					if roomplayer.save
			    		params[:function] = "PJRO"
			    		params["client_name".to_sym] = params[:username]
			    		params[:data] = "username\r" + params[:client_name] +"\n"
						packet.data = "OK"			    		
			    		communication.notif(params)

					else
						packet.data = 'KO'
						log_error('[joro]  ' + roomplayer.errors.messages)
					end
				else
					packet.data = 'KO'
					log_error('[joro]  ' + room.errors.messages)
				end
			end
		else
			packet.data = 'KO'
			log_error("[joro]  one of the parameters is missing or doesn't exist(username => [#{params[:username]}]  room => [#{params[:nameRoom]}]")
		end
		packet
	end

	# Action lear
	#
	# Leave room
	# === Parameters
	# * +username+ - (string)
	# * +nameRoom+ - (string)
	# * +client_name+ - (string) - Same as username, this is used by communication to make the notification module working
	# === Success
	#   OK
	# === Fail
	#   KO

	def lear(packet, params)
		if params[:username] && params[:nameRoom]
			users = User.find_by_username(params[:username])
			room = Room.find_by_nameRoom(params[:nameRoom])
			if users.nil? || room.nil?
				packet.data = "KO"
				log_error("[lear]  user #{params[:username]} or room #{params[:nameRoom]} doesn't exist")
			else
				roomplayer = Roomplayer.find_by_idUser_and_idRoom(users.id, room.id)
				if roomplayer.nil?
					packet.data = "KO"
					log_error("[lear]  user #{params[:username]} is not in the room #{params[:nameRoom]}")
				else
					room.nbPlayer = room.nbPlayer - 1;
					if room.save
						clean_roomplayer(users, room)
						params[:function] = "PLRO"
						params["client_name".to_sym] = params[:username]
		    			params[:data] = "username\r" + params[:client_name]
						packet.data = "OK"
		    			communication.notif(params)
		    			if room.nbPlayer == 0
		    				#clean_depth(room)
		    				room.delete
		    			end
					else
						packet.data = 'KO'
						log_error('[lear]  ' + room.errors.messages)
					end
				end
			end
		else
			packet.data = 'KO'
			log_error("[joro]  one of the parameters is missing or doesn't exist(username => [#{params[:username]}]  room => [#{params[:nameRoom]}]")
		end
		packet
	end

	# Action gpfr
	#
	# Get player from a room
	# === Parameters
	# * +idRoom+ - (integer) - This represents the id of the room you want to get a list of players
	# === Success
	#   id\r\nusername1\nusername2\nusername3\n
	# === Fail
	#   KO

	def gpfr(packet, params)
		if params[:idRoom]
			begin 
				Room.find(params[:idRoom])
				listPlayer = Roomplayer.where(["idRoom = ?", params[:idRoom]])
				packet.data = ""
				listPlayer.each do |item|
					user = User.where(["id = ?", item.idUser])
					packet.data += "#{user[0].username}\n"
				end
			rescue   ActiveRecord::RecordNotFound
				packet.data = 'KO'
				log_error("[gpfr]  room with id #{params[:idRoom]} doesn't exist")
			end
		else
			packet.data = 'KO'
			log_error("[gpfr]  room  id is missing")
		end
		packet 
	end

	# Action gear
	#
	# Get all room
	# === Success
	#  	 id\r1\nnameOwner\rexample_name\nformat\rVintage\nnameRoom\rexample_name_room\nstate\r1\n
	# === Fail
	#    KO

	def gear(packet, params)
		rooms = Room.all
	    if rooms.empty?
	    	packet.data = "KO"
	    	log_error("[gear]  no rooms")
	    else
	    	packet.data = ""
	    	rooms.each do |room|
				%w[id nameOwner format nameRoom state].each do | elem |
					packet.data += "#{elem}\r#{room.send(elem.to_sym)}\n"
				end
			end
	   #     	rooms.each do | elem |
	   #  		packet.data += "id\r"
				# packet.data += "#{elem.id}\n"
				# packet.data += "nameOwner\r"
				# packet.data += "#{elem.nameOwner}\n"
				# packet.data += "format\r"
				# packet.data += "#{elem.format}\n"
				# packet.data += "nameRoom\r"
				# packet.data += "#{elem.nameRoom}\n"
				# packet.data += "state\r"
				# packet.data += "#{elem.state}\n"
	   #     	end
	    end  
		packet
   	end

end