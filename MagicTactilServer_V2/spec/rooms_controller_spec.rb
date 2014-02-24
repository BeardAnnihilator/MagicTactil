require 'spec_helper'

describe Room do 
	before :each do 
		@protocol = Protocol.new({}, Mutex.new)
		@packet = Packet.new
	end


	describe "Create room" do
		before :each do 
			@params = { :nameRoom => "room 2",
					:nameOwner => "mick",
					:format => "Standard",
					:state => 1
					}
			@protocol.cnro(@packet, @params)
			@params[:nameRoom] = "room 1"
		end

		after :each do 
			Room.delete_all
			Roomplayer.delete_all
		end

		it "should create room" do 
			@packet = @protocol.cnro(@packet, @params)
			room_id = Room.find_by_nameRoom("room 1").id
			@packet.data.should eql(room_id.to_s)
		end

		it "should not create room (room already exist)" do 
			@params[:nameRoom] = 'room 2'
			@packet = @protocol.cnro(@packet, @params)
			@packet.data.should eql('KO')
		end


		it "should not create room (nameRoom is missing)" do 
			@packet = @protocol.cnro(@packet, @params.except(:nameRoom))
			@packet.data.should eql('KO')
		end

		it "should not create room (user doesn't exist)" do 
			@params[:nameOwner] = "JCVD"
			@packet = @protocol.cnro(@packet, @params)
			@packet.data.should eql('KO')
		end

		it "should not create room (nameOwner is missing)" do 
			@packet = @protocol.cnro(@packet, @params.except(:nameOwner))
			@packet.data.should eql('KO')
		end

		it "should not create room (format is missing)" do
			@packet = @protocol.cnro(@packet, @params.except(:format))
			@packet.data.should eql('KO')
		end

		it "should not create room (state doesn't exist)" do 
			@params[:state] = "8"
			@packet = @protocol.cnro(@packet, @params)
			@packet.data.should eql('KO')
		end

		it "should not create room (state is missing)" do 
			@packet = @protocol.cnro(@packet, @params.except(:state))
			@packet.data.should eql('KO')
		end


	end

	describe "Delete room " do 
		before :each do 
			@params = { :nameRoom => "room 2",
					:nameOwner => "mick",
					:format => "Standard",
					:state => 1
					}
			@protocol.cnro(@packet, @params)
		end

		after :each do 
			Room.delete_all
			Roomplayer.delete_all
		end


		it "should Delete room" do 
			@packet = @protocol.dero(@packet, @params)
			@packet.data.should eql('OK')
		end

		it "should not delete room (user doesn't exist)" do 
			@params[:nameOwner] = "JCVD"
			@packet = @protocol.dero(@packet, @params)
			@packet.data.should eql('KO')
		end

		it "should not delete room (user is not the owner of the room)" do 
			@params[:nameOwner] = "oualid"
			@packet = @protocol.dero(@packet, @params)
			@packet.data.should eql('KO')
		end

		it "should not delete room (nameOwner is missing)" do 
			@packet = @protocol.dero(@packet, @params.except(:nameOwner))
			@packet.data.should eql('KO')
		end

		it "should not delete room (room name doesn't exist)" do 
			@params[:nameRoom] = "oui oui"
			@packet = @protocol.dero(@packet, @params)
			@packet.data.should eql('KO')
		end

		it "should not delete room (nameRoom is missing)" do 
			@packet = @protocol.dero(@packet, @params.except(:nameRoom))
			@packet.data.should eql('KO')			
		end
	end

	describe "Join room" do 
		before :each do 
			@params = { :nameRoom => "room 2",
					:nameOwner => "mick",
					:format => "Standard",
					:state => 1
					}
			@protocol.cnro(@packet, @params)
			@params[:nameRoom] = "room 2"
			@params[:username] = "oualid"
		end

		after :each do 
			Room.delete_all
			Roomplayer.delete_all
		end


		it "should join room" do 
			begin
				@packet = @protocol.joro(@packet, @params)				
			rescue 
				@packet.data.should eql('OK')
			end
		end

		it "should not join room (user odesn't exist)" do 
			@params[:username] = "JCVD"
			@packet = @protocol.joro(@packet, @params)
			@packet.data.should eql('KO')
		end

		it "should not join room (user already in the room)" do 
			@params[:username] = 'mick'
			@packet = @protocol.joro(@packet, @params)
			@packet.data.should eql('KO')
		end

		it "should not join room (username is missing)" do 
			@packet = @protocol.joro(@packet, @params.except(:username))
			@packet.data.should eql('KO')
		end

		it "should not join room (room doesn't exist)" do 
			@params[:nameRoom] = "ouioui"
			@packet = @protocol.joro(@packet, @params)
			@packet.data.should eql('KO')			
		end

		it "should not join room (nameRoom is missing)" do 
			@packet = @protocol.joro(@packet, @params.except(:nameRoom))
			@packet.data.should eql('KO')			
		end

	end

	describe "Leave room" do 
		before :each do 
			@params = { :nameRoom => "room 2", :nameOwner => "mick"}
			@protocol.cnro(@packet, @params.merge({	:format => "Standard",:state => 1}))
		end

		after :each do 
			Room.delete_all
			Roomplayer.delete_all
		end

		it "should leave room" do 
			begin
				@packet = @protocol.lear(@packet, @params)
			rescue
				@packet.data.should eql('OK')
			end
		end

		it "should not leave room (user doesn't exist)" do 
			@params[:username] = "JCVD"
			@packet = @protocol.lear(@packet, @params)
			@packet.data.should eql('KO')
		end

		it "should not leave room (username is missing)" do 
			@packet = @protocol.lear(@packet, @params.except(:username))
			@packet.data.should eql('KO')
		end

		it "should not leave room (room doesn't exist)" do
			@params[:nameRoom] = "ouioui" 
			@packet = @protocol.lear(@packet, @params)
			@packet.data.should eql('KO')
		end

		it "should not leave room (nameRoom is missing)" do 
			@packet = @protocol.lear(@packet, @params.except(:nameRoom))
			@packet.data.should eql('KO')
		end


	end

	describe "Get room players " do

		before :each do 
			@params = { :nameRoom => "room 2", :nameOwner => "mick"}
			@protocol.cnro(@packet, @params.merge({	:format => "Standard",:state => 1}))
			room_id = Room.find_by_nameRoom('room 2').id
			@params[:idRoom] = room_id.to_s
		end

		after :each do 
			Room.delete_all
			Roomplayer.delete_all
		end

		it "should get all room players" do 
			@packet = @protocol.gpfr(@packet, @params)
			players = Roomplayer.where(["idRoom = ?", @params[:idRoom]])
			data = ""
			players.each do | player |
				user = User.find(player.idUser)
				data +=  "#{user.username}\n"
			end 	
			@packet.data.should eql(data)
		end 

		it "should not get all room player(room id doesn't exit)" do 
			@params[:idRoom] = "-1"
			@packet = @protocol.gpfr(@packet, @params)
			@packet.data.should eql('KO')
		end

		it "should not get all room player(idRoom is missing)" do 
			@packet = @protocol.gpfr(@packet, @params.except(:idRoom))
			@packet.data.should eql('KO')
		end

	end

	describe "Get all room" do 

		before :each do 
			@params = { :nameRoom => "room 2", :nameOwner => "mick"}
			@protocol.cnro(@packet, @params.merge({	:format => "Standard",:state => 1}))
		end

		after :each do 
			Room.delete_all
			Roomplayer.delete_all
		end


		it "should get all room" do 
			@packet = @protocol.gear(@packet, @params)
			rooms = Room.all
			data = ""
			rooms.each do |room|
				["id", "nameOwner", "format", "nameRoom", "state"].each do | elem |
					data += "#{elem}\r#{room.send(elem.to_sym)}\n"
				end
			end
			@packet.data.should eql(data)
		end

		it "should not get all room (there is no room)" do 
			Room.delete_all
			Roomplayer.delete_all
			@packet = @protocol.gear(@packet, @params)
			@packet.data.should eql('KO')
		end

	end

end
