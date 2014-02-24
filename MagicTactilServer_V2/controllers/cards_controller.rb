require './MagicTactilBDD.rb'

module	CardsController

	# Action acfd
	#
	# Add or update information of cards in a deck
	# === Parameters
	# * +nameOwner+ - (string)
	# * +deckName+ - (string)
	# * +idCard+ - (integer) - In each deck each card have an id, if you have the same card 4 times the id would be same
	# * +nbCard+ - (integer) 
	# * +isSided+ - (boolean) - In some games, the side contains cards which can be swapped with another card between two games. Can be true of false
	# === Success
	#   OK
	# === Fail
	#   KO
 
	def acfd(packet, params)
		if params[:nameOwner] && params[:deckName]
			if isDeckExist = Deck.find_by_nameOwner_and_deckName(params[:nameOwner], params[:deckName])
				isCardExistInDeck = Deckcard.find_by_idDeck_and_idCard(isDeckExist.idDeck, params[:idCard])
					if params[:nbCard] && params[:isSided] && params[:idCard]
						if isCardExistInDeck.nil?
							cardAdded = Deckcard.new(params.except(:client_name, :nameOwner, :deckName), :idDeck => isDeckExist.idDeck )
							cardAdded.idDeck = isDeckExist.idDeck
							if cardAdded.save
								packet.data = "OK"
							else
								packet.data = "KO"
								log_error('[acfd]  ' + cardAdded.errors.messages.to_s)
							end
						elsif params[:nbCard].to_i != isCardExistInDeck.nbCard.to_i ||
						 		params[:isSided] != isCardExistInDeck.isSided.to_s
							isCardExistInDeck.nbCard = params[:nbCard]
							isCardExistInDeck.isSided = params[:isSided]
							isCardExistInDeck.save
							packet.data = "OK"
						end
					else
						packet.data = "KO"
						log_error("[scfd]  nbCard, isSided or idCard is missing")
					end
			else
				packet.data = "KO"
				log_error("[acfd]  deck #{params[:deckName]} of the user #{params[:nameOwner]} doesn't exist")
			end
		else
			packet.data = "KO"
			log_error("[acfd]  nameOwner or deckName is missing")
		end 
		packet
	end

	# Action rcfd
	#
	# Remove card from a deck
	# === Parameters
	# * +nameOwner+ - (string)
	# * +deckName+ - (string)
	# * +idCard+ - (integer) - In each deck each card have an id, if you have the same card 4 times the id would be same
	# === Success
	#   OK
	# === Fail
	#   KO


	def rcfd(packet, params)
		if params[:nameOwner] && params[:deckName] && params[:idCard]
			isDeckExist = Deck.find_by_nameOwner_and_deckName(params[:nameOwner], params[:deckName])
			if isDeckExist.nil?
				packet.data = "KO"
				log_error("[acfd]  deck #{params[:deckName]} of the user #{params[:nameOwner]} doesn't exist")
			else
				isCardExistInDeck = Deckcard.find_by_idDeck_and_idCard(isDeckExist.idDeck, params[:idCard])
				#debugger
				if isCardExistInDeck
					isCardExistInDeck.destroy
					packet.data = "OK"
				else
					packet.data = "KO"
					log_error("[acfd]  card[#{params[:idCard]}] isn't in deck #{params[:deckName]} of the user #{params[:nameOwner]}")
				end
			end
		else
			packet.data = "KO"
			log_error("[acfd]  nameOwner, idCard or deckName is missing")
		end
		packet
	end
end