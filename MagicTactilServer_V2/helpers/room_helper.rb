require './MagicTactilBDD.rb'

def clean_room(user)
	if ((r = Room.find_by_nameOwner(user.username)))
		roomplayers = Roomplayer.where("idRoom = ?", r.id)
		if (!roomplayers.empty?)
			roomplayers.each do |roomplayer|
				roomplayer.delete
			end
			r.destroy
		end	
	else
	  	roomplayer = Roomplayer.find_by_idUser(user.id)
	  	roomplayer.destroy		
	end
end

def clean_roomplayer(user, room)
	if ((roomplayer = Roomplayer.find_by_idUser_and_idRoom(user.id, room.id)))
		roomplayer.destroy
	end
end 

def clean_depth(room)
	roomplayers = Roomplayer.where("idRoom = ?", room.id)
		if (!roomplayers.empty?)
			roomplayers.each do |roomplayer|
				roomplayer.delete
			end
		end	
	room.delete
end

def check_if_all_client_are_ready(packet, params)
	listPlayer = Roomplayer.where(["idRoom = ?", params[:idRoom]])
	room = Room.find_by_idRoom(params[:idRoom])
	if listPlayer.nil? && room.nil?
		puts("Nobody is in the room with the id : #{params[:idRoom]}")
	else
		if listPlayer.length == room.size
			send_to_user(params)
		end
	end
end

def send_to_user(params)
		params[:data] = "OK"
		params[:function] = "CIAP"
		communication.notif(params)
end