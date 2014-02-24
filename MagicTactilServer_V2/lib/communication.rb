require './MagicTactilBDD.rb'

class  Communication

	def initialize(all_client, mutex_all_client)
		@all_client =  all_client
		@mutex_all_client = mutex_all_client
	end

	# private message
	def MESP(params)
		packet = Packet.new
		packet.headPacket[0] = 0;
		packet.headPacket[1] = 0;
		packet.headPacket[2] = params[:message].size
		packet.headPacket[3] = "MESP"
		packet.data = params[:message]
		@mutex_all_client.synchronize {
			@all_client[params[:username]].syswrite(packet.headPacket.pack("llla*"))
			@all_client[params[:username]].syswrite(packet.data)
		}
		return ("OK")
	end
	
	# broadcast message
	def MESB(params)
#	  puts "-------------------FUNCTION MESB--------------------------"
		packet = Packet.new
		packet.headPacket[0] = 0;
		packet.headPacket[1] = 0;
		packet.headPacket[2] = params[:message].size
		packet.headPacket[3] = "MESB"
		packet.data = params[:message]

		nameRoom = Room.find_by_nameRoom(params[:nameRoom])

#		puts "name of the room " + params[:nameRoom] + " | id of the room " + nameRoom.id.to_s
		
#		puts "###########   list of player connected"
		@all_client.each do |key, value|
			puts key
		end
#		puts "                end           \n\n\n"

		#listplayer = Roomplayer.find_by_idRoom(nameRoom.id)

		listplayer = Roomplayer.where(["idRoom = ?",nameRoom.id])
#		puts "====> loop to send packet for each player connected in the room"
		listplayer.each do |player|
 #           puts "-----------player-------------------"
            p player
			name = User.find_by_id(player.idUser)
#			puts "name of the player " + name.username
			puts name.username + " != " +  params[:client_name]
			if (name.username != params[:client_name])
#				puts "     yes "
				@mutex_all_client.synchronize {
					@all_client[name.username].syswrite(packet.headPacket.pack("llla*"))
					@all_client[name.username].syswrite(packet.data)
#					puts "packet "
#					p packet
#					puts "sent to player " + name.username
				}
			else
#				puts "     no "
			end

#			puts "\n\n\n"	
		end
#		puts "===========>end loop"
#		puts "----------------------END FONCTION MESB----------------------------------"
		return ("OK")	
	end

  def notif(params)
		packet = Packet.new
		packet.headPacket[0] = 0;
		packet.headPacket[1] = 0;
		packet.headPacket[2] = params[:data].size
		packet.headPacket[3] = params[:function]
		packet.data = params[:data]
		nameRoom = Room.find_by_nameRoom(params[:nameRoom])
		listplayer = Roomplayer.where(["idRoom = ?", nameRoom.id])
		listplayer.each do |player|
#    	  puts "-----------player-------------------"
#    	  p player
			name = User.find_by_id(player.idUser)
			if (name.username != params[:client_name])
				@mutex_all_client.synchronize {
#					print "All client in Communication#notif with username #{name.username}: "; p @all_client
					@all_client[name.username].syswrite(packet.headPacket.pack("llla*"))
					@all_client[name.username].syswrite(packet.data)
#					puts "packet "
#					p packet
#					puts "sent to player " + name.username
				}
			end
#			puts "\n\n\n"	
		end
		return ("OK")
  end
end
