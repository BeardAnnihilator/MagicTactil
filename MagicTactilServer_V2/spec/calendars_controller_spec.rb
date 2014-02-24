require 'spec_helper'

describe CalendarsController  do

	before :each do
		@protocol = Protocol.new({}, "Mutex")
		@packet = Packet.new
		@params = {}
	end

	describe "Create event" do

	before :each do 
		@params[:creator] = "mick"
		@params[:name] = "new event 2"
		@params[:creatorEmail] = "pucheu_m@epitech.eu"
		@params[:description] = "a new event"
		@params[:idUser] = "2"
		@params[:date] = "12/12/2014"
		@params[:location] = "marseille"
		@packet = @protocol.crev(@packet, @params)
	end

	after :each do 
		Event.delete_all
	end

		it "should not add new entry (creator is missing)" do
			@params[:name] = "new event 2"
			@params[:creatorEmail] = "pucheu_m@epitech.eu"
			@params[:description] = "a new event"
			@params[:idUser] = "2"
			@params[:date] = "12/12/2014"
			@params[:location] = "marseille"
			@packet = @protocol.crev(@packet, @params)
			@packet.data.should eql('KO')
		end

		it "should not add new entry (name is missing)" do
			@params[:creator] = "mick"
			@params[:creatorEmail] = "pucheu_m@epitech.eu"
			@params[:description] = "a new event"
			@params[:idUser] = "2"
			@params[:date] = "12/12/2014"
			@params[:location] = "marseille"
			@packet = @protocol.crev(@packet, @params)			
			@packet.data.should eql('KO')
		end

		it "should not add entry (creatorEmail is missing)" do
			@params[:creator] = "mick"
			@params[:name] = "new event 2"
			@params[:description] = "a new event"
			@params[:idUser] = "2"
			@params[:date] = "12/12/2014"
			@params[:location] = "marseille"
			@packet = @protocol.crev(@packet, @params)			
			@packet.data.should eql('KO')			
		end

		it "should not add entry (description is missing)" do
			@params[:creator] = "mick"
			@params[:name] = "new event 2"
			@params[:creatorEmail] = "pucheu_m@epitech.eu"
			@params[:idUser] = "2"
			@params[:date] = "12/12/2014"
			@params[:location] = "marseille"
			@packet = @protocol.crev(@packet, @params)			
			@packet.data.should eql('KO')			
		end	

		it "should not add entry (date is missing)" do
			@params[:creator] = "mick"
			@params[:name] = "new event 2"
			@params[:creatorEmail] = "pucheu_m@epitech.eu"
			@params[:description] = "a new event"
			@params[:idUser] = "2"
			@params[:location] = "marseille"
			@packet = @protocol.crev(@packet, @params)			
			@packet.data.should eql('KO')
		end

		it "should not add entry (location is missing)" do
			@params[:creator] = "mick"
			@params[:name] = "new event 2"
			@params[:creatorEmail] = "pucheu_m@epitech.eu"
			@params[:description] = "a new event"
			@params[:idUser] = "2"
			@params[:date] = "12/12/2014"
			@packet = @protocol.crev(@packet, @params)			
			@packet.data.should eql('KO')						
		end

		it "should add a new entry in database" do
			@params[:creator] = "mick"
			@params[:name] = "new event 4"
			@params[:creatorEmail] = "pucheu_m@epitech.eu"
			@params[:description] = "a new event 4"
			@params[:idUser] = "2"
			@params[:date] = "12/12/2014"
			@params[:location] = "marseille"
			@packet = @protocol.crev(@packet, @params)
			@packet.data.should eql('OK')
		end

		it "should not add entry (name event already existe)" do
			@params[:creator] = "mick"
			@params[:name] = "new event 2"
			@params[:creatorEmail] = "pucheu_m@epitech.eu"
			@params[:description] = "a new event"
			@params[:idUser] = "2"
			@params[:date] = "12/12/2014"
			@params[:location] = "marseille"
			@packet = @protocol.crev(@packet, @params)
			@packet.data.should eql('KO')
		end

	end


	describe "Sign up event" do

	before :each do 
		@params[:creator] = "mick"
		@params[:name] = "new event 2"
		@params[:creatorEmail] = "pucheu_m@epitech.eu"
		@params[:description] = "a new event"
		@params[:idUser] = "2"
		@params[:date] = "12/12/2014"
		@params[:location] = "marseille"
		@protocol.crev(@packet, @params)
		@protocol.sgue(@packet, {:username => "oualid", :name => "new event 2"})
		@params = {}
	end

	after :each do 
		Event.delete_all
	end

		
		it "should not sign up a user to the event(username is missing)" do 
			@params[:name] = "new event 2"
			@packet = @protocol.sgue(@packet, @params)
			@packet.data.should eql('KO')
		end

		it "should not sign up a user to the event(name is missing)" do 
			@params[:username] = "mick"
			@packet = @protocol.sgue(@packet, @params)
			@packet.data.should eql('KO')
		end

		it "should not sign up a user the event(user doesn't exist)" do
			@params[:username] = "JCVD"
			@params[:name] = "new event 2"
			@packet = @protocol.sgue(@packet, @params)
			@packet.data.should eql('KO')
		end


		it "should not sign up a user to the event(event doesn't exist)" do
			@params[:username] = "mick"
			@params[:name] = "oui oui"
			@packet = @protocol.sgue(@packet, @params)
			@packet.data.should eql('KO')
		end

		it "should sign up a user to the event" do
			@params[:username] = "mick"
			@params[:name] = "new event 2"
			@packet = @protocol.sgue(@packet, @params)
			@packet.data.should eql('OK')
		end

		it "should not sign up a user to the event(user already signed up to the event)" do
			@params[:username] = "oualid"
			@params[:name] = "new event 2"
			@packet = @protocol.sgue(@packet, @params)
			@packet.data.should eql('KO')
		end
	
	end

	describe "Sign out event" do

	before :each do 
		@params[:creator] = "mick"
		@params[:name] = "new event 2"
		@params[:creatorEmail] = "pucheu_m@epitech.eu"
		@params[:description] = "a new event"
		@params[:idUser] = "2"
		@params[:date] = "12/12/2014"
		@params[:location] = "marseille"
		@protocol.crev(@packet, @params)
		@protocol.sgue(@packet, {:username => "mick", :name => "new event 2"})
		@params = {}
	end

	after :each do 
		Event.delete_all
	end


		it "should not sign out to the event(username is missing)" do
			@params[:name] = "new event 2"
			@packet = @protocol.sgoe(@packet, @params)
			@packet.data.should eql('KO')
		end

		it "should not sign out to the event(name is missing)" do
			@params[:username] = "mick"
			@packet = @protocol.sgoe(@packet, @params)
			@packet.data.should eql('KO')
		end

		it "should not sign out to the event(name doesn't existe)" do
			@params[:username] = 'mick'
			@params[:name] = 'new event 28'
			@packet = @protocol.sgoe(@packet, @params)
			@packet.data.should eql('KO')
		end

		it "should not sign out to the event(username doesn't existe)" do
			@params[:username] = 'JCVD'
			@params[:name] = 'new event 2'
			@packet =  @protocol.sgoe(@packet, @params)
			@packet.data.should eql('KO')
		end

		it "should sign out to the event" do
			@params[:username] = 'mick'
			@params[:name] = 'new event 2'
			@packet = @protocol.sgoe(@packet, @params)
			@packet.data.should eql('OK')
		end

		it "should not sign out to the event (user has already signed up to the event )" do 
			@params[:username] = 'mick'
			@params[:name] = 'new event 2'
			@packet = @protocol.sgoe(@packet, @params)
			@packet = @protocol.sgoe(@packet, @params)
			@packet.data.should eql('KO')
		end

	end

	describe "Delete event" do

		before :each do 
			@params[:creator] = "mick"
			@params[:name] = "new event 2"
			@params[:creatorEmail] = "pucheu_m@epitech.eu"
			@params[:description] = "a new event"
			@params[:idUser] = "2"
			@params[:date] = "12/12/2014"
			@params[:location] = "marseille"
			@protocol.crev(@packet, @params)
			@params = {}
		end

		after :each do 
			Event.delete_all
		end


		it "should delete event form the DB" do
			@packet = @protocol.dele(@packet, {:name => "new event 2"})
			@packet.data.should eql('OK')
		end

		it "should not delete event from the BD(name doesn't existe)" do
			@packet = @protocol.dele(@packet, @params)
			@packet.data.should eql('KO')
		end

		it "should not delete event form the DB(event doesn't existe)" do 
			@params[:name] = 'new event 28'
			@packet = @protocol.dele(@packet, @params)
			@packet.data.should eql('KO')
		end

	end
	
	describe "Set new information of the event" do

		before :each do 
			@params[:creator] = "mick"
			@params[:name] = "new event 2"
			@params[:creatorEmail] = "pucheu_m@epitech.eu"
			@params[:description] = "a new event"
			@params[:idUser] = "2"
			@params[:date] = "12/12/2014"
			@params[:location] = "marseille"
			@protocol.crev(@packet, @params)
			@params = {}
		end

		after :each do 
			Event.delete_all
		end


		it "should set description of the event" do
			@params[:name] = 'new event 2'
			@params[:description] = "descirption updated"
			@packet = @protocol.snie(@packet, @params)
			@packet.data.should eql('OK')
		end

		it "should not set description ot the event(event doesn't existe)" do
			@params[:name] = 'new event 28'
			@params[:description] = "description updated"
			@packet = @protocol.snie(@packet, @params)
			@packet.data.should eql('KO')
		end

		it "should not set description ot the event(event name is missing)" do
			@params[:description] = "description updated"
			@packet = @protocol.snie(@packet, @params)
			@packet.data.should eql('KO')
		end

		it "should set date of the event" do
			@params[:name] = 'new event 2'
			@params[:date] = '30/12/2014'
			@packet = @protocol.snie(@packet, @params)
			@packet.data.should eql('OK')
		end

		it "should not set date of the event(event doesn't existe)" do
			@params[:name] = 'new event 34'
			@params[:date] = '31/12/2014'
			@packet = @protocol.snie(@packet, @params)
			@packet.data.should eql('KO')
		end

		it "should not set date of the event(event name is missing)" do
			@params[:date] = '24/12/2014'
			@packet = @protocol.snie(@packet, @params)
			@packet.data.should eql('KO')
		end

		it "should set location ot the event" do
			@params[:name] = 'new event 2'
			@params[:location] = 'paris'
			@packet = @protocol.snie(@packet, @params)
			@packet.data.should eql('OK')
		end

		it "should not set location of the event(event doesn't existe)" do
			@params[:name] = 'new event 34'
			@params[:loaction] = 'Paris'
			@packet = @protocol.snie(@packet, @params)
			@packet.data.should eql('KO')
		end

		it "should not set location of the event(event name is missing)" do
			@params[:loaction] = 'Paris'
			@packet = @protocol.snie(@packet, @params)
			@packet.data.should eql('KO')
		end

	end


	describe "Get event" do
		before :each do 
			@params[:creator] = "mick"
			@params[:name] = "new event 2"
			@params[:creatorEmail] = "pucheu_m@epitech.eu"
			@params[:description] = "a new event"
			@params[:idUser] = "2"
			@params[:date] = "12/12/2014"
			@params[:location] = "marseille"
			@protocol.crev(@packet, @params)
			@params = {}
		end

		after :each do 
			Event.delete_all
		end



		it "should get event" do
			@params[:name] = 'new event 2'
			@packet = @protocol.gete(@packet, @params)
			event = Event.find_by_name('new event 2')
			@packet.data.should eql("id\r#{event.id}\ncreator\r#{event.creator}\nname\r#{event.name}\ndescription\r#{event.description}\ndate\r#{event.date}\nlocation\r#{event.location}")
		end

		it "should not get event(event doesn't existe)" do
			@params[:name] = 'new event 28'
			@packet = @protocol.gete(@packet, @params)
			@packet.data.should eql('KO')
		end

		it "should not get event(name is missing)" do
			@packet = @protocol.gete(@packet, @params)
			@packet.data.should eql('KO')
		end

	end

	describe "Get all events" do
		it "should get all events" do
			@packet = @protocol.gtal(@packet, @params)
			event = Event.all
			resp = ""
			event.each do | elem |
 	       		resp += "#{elem.name}\n"
 	    	end
			@packet.data.should eql(resp)
		end
	end

	describe "Check if someone has already signed up" do
		before :each do 
			@params[:creator] = "mick"
			@params[:name] = "new event 2"
			@params[:creatorEmail] = "pucheu_m@epitech.eu"
			@params[:description] = "a new event"
			@params[:idUser] = "2"
			@params[:date] = "12/12/2014"
			@params[:location] = "marseille"
			@protocol.crev(@packet, @params)
			@params = {}
		end

		after :each do 
			Event.delete_all
		end


		it "should not check if someone has already signed up(username is missing)" do
			@params[:name] = 'new event 2'
			@packet = @protocol.isue(@packet, @params)
			@packet.data.should eql('KO')
		end

		it "should not check if someone has already signed up(name is missing)" do
			@params[:username] = 'mick'
			@packet = @protocol.isue(@packet, @params)
			@packet.data.should eql('KO')			
		end

		it "should not check if the user has already signed up(username doesn't existe)" do
			@params[:name] = 'new event 2'
			@params[:username] = 'JCVD'
			@packet = @protocol.isue(@packet, @params)
			@packet.data.should eql('KO')		
		end

		it "should not check if the user has already signed up(name doesn't existe)" do
			@params[:name] = 'new event 29'
			@params[:username] = 'mick'
			@packet = @protocol.isue(@packet, @params)
			@packet.data.should eql('KO')		
		end

		it "should check if the user has already signed up(OK and KO)" do
			@params[:name] = 'new event 2'
			@params[:username] = 'mick'
			@packet = @protocol.sgue(@packet, @params)
			@packet.data.should eql('OK')
			@packet = @protocol.isue(@packet, @params)
			@packet.data.should eql('OK')		
		end
	end

end

