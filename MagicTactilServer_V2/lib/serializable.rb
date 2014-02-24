# serialize packet according to the protocol
module Serializable
  def serialize(params)
    infos = []
    params.each {|key, value| infos << "#{key}\r#{value}\n" }
    infos.join(',').tr(',', '')
  end
end