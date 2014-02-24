# This class provide handler of functions.
# A function represent a command defined by the protocol

require         './controllers/authentications_controller.rb'
require         './controllers/profiles_controller.rb'
require         './controllers/calendars_controller.rb'
require         './controllers/rooms_controller.rb'
require         './controllers/friend_blacklists_controller.rb'
require         './controllers/decks_controller.rb'
require         './controllers/cards_controller.rb'
require         './controllers/game_samples_controller.rb'

require         './lib/communication.rb'
require         './lib/serializable.rb'

# this class is used to handle the packet treatment process
class           Protocol
  attr_accessor :communication

  include       AuthenticationsController
  include       ProfilesController
  include       CalendarsController
  include       FriendBlacklistsController
  include       DecksController
  include       CardsController
  include       GameSamplesController
  include       RoomsController

  # helper modules
  include       Serializable

  def           initialize(all_client, mutex_all_client)
    @communication = Communication.new(all_client, mutex_all_client)
  end

  def mesp(packet, params)
    packet.data = @communication.MESP(params)
  end

  def mesb(packet, params)
    packet.data = @communication.MESB(params)
  end

  def call_action action, packet, params
    begin
      send(action, packet, params)
    rescue NoMethodError => e
      log_error("[#{__FILE__}:#{__LINE__ - 2}]    #{e.message}")
      return (false)
    end
    return (true)
  end
end
