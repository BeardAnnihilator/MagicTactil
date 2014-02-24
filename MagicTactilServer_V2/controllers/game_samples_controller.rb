require './MagicTactilBDD.rb'
# Zones: hand, game zone, graveyard, exiled, library, deck, opponent game zone.

#params roomName, client_name

module GameSamplesController

	# Action move
	#
	# Move a card from a place to another
	# === Parameters
	# * +idCard+ - (integer) - The id of the card on the board the user who sent the request want to move
	# * +source+ - (string) - Where the card is from ( hand, board, graveyard, exile, deck, enemy board)
	# * +destination+ - (string) - the source where you want the card to be put
	# * +posX+ - (integer) - This is a pourcentage
	# * +posY+ - (integer) - This is a pourcentage
	# * +url+ - (string) - The url of the card we want to move, permit to display the card
	# * +client_name+ - (string) - This is the username you have chosen when you created the account, this is used to make the notif function working
	# * +roomName+ - (string)
	# === Success
	#   OK
	# === Fail 
	#   - Cannot fail if there is nobody to send the message to, the function notif in communication module will just any message -
	
	def move(packet, params)
		params[:data] = serialize(params.except(:client_name))
		#p params[:data]
		params[:function] = "MOVE"
		communication.notif(params)
		packet.data = "OK"
	end

	# Action tapc
	#
	# Tap a specific card (Horizontal from vertical)
	# === Parameters
	# * +idCard+ - (integer) - The id (on the board) of the card, the user who send the request want to tap
	# * +client_name+ - (string) - This is the username you have chosen when you created the account, this is used to make the notif function working
	# * +roomName+ - (string)
	# === Success
	#   OK
	# === Fail 
	#   - Cannot fail if there is nobody to send the message to, the function notif in communication module will just any message -
	
	def tapc(packet, params)
		params[:data] = serialize(params.except(:client_name))
		params[:function] = "TAPC"
		communication.notif(params)
		packet.data = "OK"
	end

	# untap a specific card (Vertical from horizontal)
	# Action utap
	#
	# Untap a specific card (Vertical from horizontal)
	# === Parameters
	# * +idCard+ - (integer) - This is the id (on the board) of the card the user who sent the request want to untap
	# * +client_name+ - (string) - This is the username you have chosen when you created the account, this is used to make the notif function working
	# * +roomName+ - (string)
	# === Success
	#   OK
	# === Fail 
	#   - Cannot fail if there is nobody to send the message to, the function notif in communication module will just any message -
	
	def utap(packet, params)
		params[:data] = serialize(params.except(:client_name))
		params[:function] = "UTAP"
		communication.notif(params)
		packet.data = "OK"
	end

	# Action utaa
	#
	# Untall all card
	# === Parameters
	# * +client_name+ - (string) - This is the username you have chosen when you created the account, this is used to make the notif function working
	# * +roomName+ - (string)
	# === Success
	#   OK
	# === Fail 
	#   - Cannot fail if there is nobody to send the message to, the function notif in communication module will just any message -
	
	def utaa(packet, params)
		params[:data] = serialize(params.except(:client_name))
		params[:function] = "UTAA"
		communication.notif(params)
		packet.data = "OK"
	end


	# Action upgi
	#
	# Update information from the game ( Healthpoints, ... )
	# === Parameters
	# * +healthpoints+ - (integer)
	# * +client_name+ - (string) - This is the username you have chosen when you created the account, this is used to make the notif function working
	# * +roomName+ - (string)
	# === Success
	#   OK
	# === Fail 
	#   - Cannot fail if there is nobody to send the message to, the function notif in communication module will just any message - 
	
	def upgi(packet, params)
		params[:data] = serialize(params.except(:client_name))
		params[:function] = "UPGI"
		communication.notif(params)
		packet.data = "OK"
	end

	# draw arrow from card A to card B
	# Action daab
	#
	# Draw arrow from card A to card B
	# === Parameters
	# * +idCardA+ - (integer) - This is the id ( on the board ) of the card A
	# * +idCardB+ - (integer) - This is the id ( on the board ) of the card B
	# * +client_name+ - (string) - This is the username you have chosen when you created the account, this is used to make the notif function working
	# * +roomName+ - (string)
	# === Success
	#   OK
	# === Fail 
	#   - Cannot fail if there is nobody to send the message to, the function notif in communication module will just any message -
	
	def daab(packet, params)
		params[:data] = serialize(params.except(:client_name))
		params[:function] = "DAAB"
		communication.notif(params)
		packet.data = "OK"
	end

	# Action sywl
	#
	# Give up the game
	# === Parameters
	# * +client_name+ - (string) - This is the username you have chosen when you created the account, this is used to make the notif function working
	# * +roomName+ - (string)
	# === Success
	#   OK
	# === Fail 
	#   - Cannot fail if there is nobody to send the message to, the function notif in communication module will just any message -
	
	def sywl(packet, params)
		params[:data] = serialize(params.except(:client_name))
		params[:function] = "SYWL"
		communication.notif(params)
		packet.data = "OK"
	end

	# Action rset
	#
	# Reset the game
	# === Parameters
	# * +client_name+ - (string) - This is the username you have chosen when you created the account, this is used to make the notif function working
	# * +roomName+ - (string)
	# === Success
	#   OK
	# === Fail 
	#   - Cannot fail if there is nobody to send the message to, the function notif in communication module will just any message -
	
	def rset(packet, params)
		params[:data] = serialize(params.except(:client_name))
		params[:function] = "RSET"
		communication.notif(params)
		packet.data = "OK"
	end
end