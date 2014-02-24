$LOAD_PATH << '~/project/Magictactil/server/'
# require 'debugger'
require './lib/packet'
require './Protocol'
require 'socket'                # Get sockets from stdlib
require 'thread'

server = TCPServer.open("0.0.0.0", 3000)   # Socket to listen on port 3000

All_client = {}
mutex_all_Client = Mutex.new
protocol = Protocol.new(All_client, mutex_all_Client)

$debug = false

if ARGV && ARGV[0] == "-d"
	$debug = true 
	puts "the serveur is running in debug mode"
end



def split_data_to_params(packet)

	params = {}
	buff = packet.data.split(/\n/)
	buff.each do |item|
	  tmp = item.split(/\r/)
	  params[tmp[0].to_sym] = tmp[1]
	end
	packet.data = ''
	params
end


def init_client (all_client,  client, protocol, mutex)

	while true do
		packet = Packet.new
		packet.headPacket = client.read(16).unpack("llla*")
		packet.data = client.read(packet.headPacket[2])
		params = split_data_to_params(packet)
		#puts "--- params  ---"
		#p params
		#puts "---  packet 1 ---"
		#p packet
		#puts "---  packet 2 ---"
		protocol.send packet.headPacket[3].downcase.to_sym, packet, params
		#p packet
		packet.headPacket[2] = packet.data.length
		# p packet
		if packet.headPacket[3].downcase == "sgni" && packet.data == "OK"
			#puts "              all_client in init_client befor storage"
			#p all_client
			mutex.synchronize {
				all_client[params[:username]] = client
			}
			#puts "\n               params in init_client "
			#p params
			#puts "\n               all_client in init_client"
			#p all_client
			client.syswrite(packet.headPacket.pack("llla*"))
			client.syswrite(packet.data)
			#p packet
			#puts "=========================> END"
			return (params[:username])
			#break
		end
		client.syswrite(packet.headPacket.pack("llla*"))
		client.syswrite(packet.data)
#		p packet
	end

end
if $debug
	puts "server start"
end
while true
	begin
		Thread.start(server.accept) do |client|
			i = 1
			if $debug
				puts "client[#{client.object_id.to_s}] is connected"
			end
			name_client = init_client(All_client, client, protocol, mutex_all_Client)
		
			while true do                         							# Main loop client
		    	packet = Packet.new
				packet.headPacket = client.read(16).unpack("llla*")         # read headPacket(size =  16) (llla) => (int int int char*) 
				packet.data = client.read(packet.headPacket[2])             # read data with the size content in headpacket[2]
				if $debug
					print "Packet read from the client #{name_client}: "
					p packet
				end
				params = split_data_to_params(packet)
				params[:client_name] = name_client
				protocol.call_action packet.headPacket[3].downcase.to_sym, packet, params  # exec function 
				packet.headPacket[2] = packet.data.length
				if $debug
					print "packet sended to the client #{name_client}: "
					p packet
				end
				client.syswrite(packet.headPacket.pack("llla*"))
				client.syswrite(packet.data)
			end
			client.close
		end
	rescue Exception => e
		#puts "server stop"
		server.close
		break
	end
end