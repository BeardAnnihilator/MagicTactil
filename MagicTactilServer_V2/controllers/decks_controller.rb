require './MagicTactilBDD.rb'

module DecksController

	# Action sdtu
	#
	# Send deck to the user
	# === Parameters
	# * +nameOwner+ - (string)
	# * +idDeck+ - (integer) - Each has decks, each deck of each user has unique id
	# === Success
	#   idDeck\r1\nidCard\r2\nnbCard\r4\nisSided\rfalse\n
	# === Fail
	#   KO

	def sdtu(packet, params) 
		if params[:idDeck] && params[:nameOwner]
			unless Deck.find_by_idDeck_and_nameOwner(params[:idDeck], params[:nameOwner])
				packet.data = "KO"
				return packet
				log_error("[sdtu]  idDeck #{params[:idDeck]} or nameOwner #{params[:nameOwner]} doesn't existe")
			end
			if cardListFromDeck = Deckcard.where('idDeck = ?', params[:idDeck])
				packet.data = "idDeck\r" + params[:idDeck] +"\n"
				cardListFromDeck.each do |item|
					packet.data += "idCard\r#{item.idCard}\nnbCard\r#{item.nbCard}\nisSided\r#{item.isSided}\n"
				end
			end
		else
			packet.data = "KO"
		end
		packet
	end

	# Action crdk
	#
	# Create deck
	# === Parameters
	# * +nameOwner+ - (string)
	# * +deckName+ - (string)
	# * +isReal+ - (boolean) - The value can be true or false, isReal means that the user can have a real deck with cards he owns or a deck with cards he wants to buy ( wish list )
	# === Success
	#   OK
	# === Fail
	#   KO

	def crdk(packet, params) 
		if params[:deckName] && params[:nameOwner] && params[:isReal]
			unless Deck.find_by_deckName_and_nameOwner(params[:deckName], params[:nameOwner])
				if User.find_by_username(params[:nameOwner])
					newDeck = Deck.new(params.except(:client_name))
					if newDeck.save
						packet.data = "OK"
					else
						packet.data = "KO"
						log_error("[crdk]  #{newDeck.errors.messages}")
					end
				else
					packet.data = "KO"
					log_error("[crdk]  username #{params[:nameOwner]} doesn't exist")
				end
			else
				packet.data = "KO"
				log_error("[crdk]  deck  #{params[:deckName]}  already existe for the user #{params[:nameOwner]}")
			end
		else
			packet.data = "KO"	
		end
		packet
	end

	# Action glid
	#
	# Get ids of all player's deck
	# === Parameters
	# * +nameOwner+ - (string)
	# === Success
	#   idDeck\r1\ndeckName\r2\nisReal\rtrue\n
	# === Fail
	#   KO

	def glid(packet, params) 
		if params[:nameOwner]
			if User.find_by_username(params[:nameOwner])
				deckList = Deck.where(nameOwner:  params[:nameOwner])
				packet.data = ""
				unless deckList.empty?
					deckList.each do |item|
						packet.data += "idDeck\r#{item.idDeck}\ndeckName\r#{item.deckName}\nisReal\r#{item.isReal}\n"
					end
				end
			else
				packet.data = "KO"
			end
		else
			packet.data = "KO"
		end
		packet
	end
end