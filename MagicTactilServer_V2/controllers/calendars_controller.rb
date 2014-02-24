#$LOAD_PATH << '~/Desktop/EIP/'
require './MagicTactilBDD.rb'

module CalendarsController

	# Action crev
	#
	# Create Event into the database
	# === Parameters
	# * +creator+ - (string) 
	# * +name+ - (string)
	# * +creatorEmail+ - (string)
	# * +description+ - (string)
	# * +idUser+ - (integer) - Each user has an ID which is can be got by using the action "getu"
	# * +date+ - (date)
	# * +location+ - (string)
	# === Success
	#   OK
	# === Fail
	#   KO

	def crev(packet, params)
		if params[:creator] && params[:name] && params[:creatorEmail] &&
		 	params[:description] && params[:date] && params[:location]
			if Event.find_by_name(params[:name])
				packet.data = 'KO'
				log_error("[crev]  event #{params[:name]} already existes")
			else
				event = Event.new(params.except(:client_name))
				if event.save
					packet.data = "OK"
				else
					packet.data = "KO"
					log_error('[crev]  ' + event.errors.messages.to_s)
				end
			end
		else
			packet.data = 'KO'
		end
		packet
	end

	# Action sgue
	#
	# Sign up to an event
	# === Parameters
	# * +username+ - (string)
	# * +name+ - (string)
	# === Success
	#   OK
	# === Fail
	#   KO

	def sgue(packet, params)
		if params[:username] && params[:name]
			user = User.find_by_username(params[:username])
			event = Event.find_by_name(params[:name])
			if (!event.nil? && !user.nil?) 
				if Subscriber.find_by_idUser_and_idEvent(user.id, event.id)
					packet.data = 'KO'
					log_error("[sgue]  user #{params[:username]} already signed up to the event #{params[:name]}")
				else
					subs = Subscriber.new()
					subs.idEvent = event.id
					subs.idUser = user.id
					if subs.save
						packet.data = 'OK'
					else
						packet.data = 'KO'
						log_error('[sgue]  ' + subs.errors.messages.to_s)
					end
				end
			else
				packet.data = "KO"
				log_error("[sgue]  the user #{params[:username]} or event #{params[:name]} doesn't existe")
			end
		else
			packet.data = "KO"
			log_error("[sgue]  the username or name event is missing")
		end
		packet
	end

	# Action sgoe
	#
	# Sign out of an event
	# === Parameters
	# * +username+ - (string)
	# * +name+ - (string)
	# === Success
	#   OK
	# === Fail
	#   KO

	def sgoe(packet, params)
		if params[:username] && params[:name]
			users = User.find_by_username(params[:username])
			event = Event.find_by_name(params[:name])
			if (event && users)
				if (subs = Subscriber.find_by_idUser_and_idEvent(users.id, event.id))
					subs.destroy
					packet.data = "OK"				
				else
					log_error("[sgoe]  the user[#{params[:username]}] has not been signed out to the event[#{params[:name]}]")
					packet.data = 'KO'
				end
			else
				packet.data = 'KO'
				log_error("[sgoe]  user #{params[:username]} or event #{params[:name]} doesn't existe")
			end
		else
			packet.data = 'KO'
			log_error("[sgoe]  username ot name event is missing")
		end
		packet
	end

	# Action dele
	#
	# Delete event
	# === Parameters
	# * +name+ - (string)
	# === Success
	#   OK
	# === Fail
	#   KO

	def dele(packet, params)
		if params[:name]
			if (event = Event.find_by_name(params[:name]))
				event.destroy
				packet.data = 'OK'
			else
				packet.data = 'KO'
				log_error("[dele]  event #{params[:name]} doesn't existe")
			end
		else
			packet.data = 'KO'
			log_error("[dele]  name event is missing")
		end
		packet
	end

	# Action snie
	#
	# Change the information about an event
	# === Parameters
	# * +creatorEmail+ - (string)
	# * +description+ - (string)
	# * +date+ - (date)
	# * +location+ - (date)
	# === Success
	#   OK
	# === Fail
	#   KO

	def snie(packet, params)
		if  params[:name]
			if event = Event.find_by_name(params[:name])		
				#%w[creatorEmail description date location].each do |word|
				%w[description date location].each do |word|
					if params[word.to_sym].present?
						event.update_attribute(word, params[word.to_sym])
					end
				end
				if event.save
					packet.data =  'OK'
				else
					packet.data =  'KO'
					log_error('[snie]  ' + event.errors.messages.to_s)
				end
			else
				packet.data =  'KO'
				log_error("[snie]  event #{params[:name]} doesn't existe")
			end
		else
			packet.data = 'KO'
			log_error("[snie]  name event is missing")
		end
		packet
	end

	# Action gete
	#
	# Get information about an event
	#
	# === Success
	#   id\r1\ncreator\rmickael\nname\rexample\ndescription\rthis is an example\ndate\r25/12/2013\nlocation\rat home
	# === Fail
	#   KO

   def gete(packet, params)
   		if params[:name]
	        if event = Event.find_by_name(params[:name])
	           	packet.data = "id\r#{event.id}\ncreator\r#{event.creator}\nname\r#{event.name}\ndescription\r#{event.description}\ndate\r#{event.date}\nlocation\r#{event.location}"
	        else
	        	packet.data = "KO"
	        	log_error("[gete]  event #{params[:name]} doesn't existe" )
	        end
	     else
	     	packet.data = 'KO'
	     	log_error("[gete]  name event is missing")
	     end
        packet
   end

	# Action gtal
	#
	# Get the list of all events
	# === Success
	#   name1\nname2\nname3\n
	# === Fail
	#   KO

   def gtal(packet, params)
     event = Event.all
     if event.nil?
		packet.data = ""
   	    log_error("[gtal]  no events in the Data Base")
     else
	    packet.data = ""
		event.each do | elem |
 	       packet.data += "#{elem.name}\n"
 	    end
     end
     packet
   end

    # Action isue
	#
	# Check if someone has already signed up or not
	# === Parameters
	# * +username+ - (string)
	# * +name+ - (string)
	# === Success
	#   OK
	# === Fail
	#   KO

   def isue(packet, params)
   		if params[:name] && params[:username]
		    user = User.find_by_username(params[:username])
		    event = Event.find_by_name(params[:name])
		    if user.nil? || event.nil?
		    	packet.data = 'KO'
		        log_error("[isue]  user #{params[:username]} or event #{params[:name]} doesn't existe")
		    else
		    	check = Subscriber.find_by_idUser_and_idEvent(user.id, event.id)
		        if check.nil?
		        	packet.data = 'KO'
		          	log_error("[isue]  the user has not been signed up to the event")
		        else
		          packet.data = 'OK'
		        end
		    end
		else
			packet.data = "KO"
			log_error("[isue]  name event or username is missing")
		end
     packet
   end
   
 end 