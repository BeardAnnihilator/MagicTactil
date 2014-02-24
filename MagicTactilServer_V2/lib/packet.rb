# this class contains the definition of a packet according to the protocol
# established according to the client side.
class Packet
  attr_accessor :data, :headPacket
  def initialize
    @headPacket = []
  end
end
