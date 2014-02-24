require 'spec_helper'

describe Deck do
	before :each do 
		@protocol = Protocol.new({}, 'mutex')
		@packet = Packet.new
		@params = {:nameOwner => "oualid"}
	end

	describe "crdk" do 

		after :each do 
			Deck.delete_all
		end

		it "should add deck to the user" do 
			@packet = @protocol.crdk(@packet, {:nameOwner => "oualid", :deckName => "toto", :isReal => "false"})
			@packet.data.should eql("OK")
			d = Deck.where(nameOwner:  "oualid")
			d.first.deckName.should eql("toto")
		end

		it "should not add  deck to the user (deck already existe)" do
			@protocol.crdk(@packet, {:nameOwner => "oualid", :deckName => "toto", :isReal => "false"})
			@packet = @protocol.crdk(@packet, {:nameOwner => "oualid", :deckName => "toto", :isReal => "false"})
			@packet.data.should eql("KO")
		end

		it "should not add deck ti the user (deck name is missing)" do 
			@packet = @protocol.crdk(@packet, {:nameOwner => "oualid", :isReal => "false"})
			@packet.data.should eql("KO")
		end

		it "should not add deck to the user (nameOwner doesn't exist)" do 
			@packet = @protocol.crdk(@packet, {:nameOwner => "JCVD", :deckName => "toto", :isReal => "false"})
			@packet.data.should eql("KO")
		end

		it "should not add deck to the user (nameOwner is missing)" do 
			@packet = @protocol.crdk(@packet, {:deckName => "toto", :isReal => "false"})
			@packet.data.should eql("KO")
		end

		it "should not add deck to the user (isReal is missing)" do 
			@packet = @protocol.crdk(@packet, {:nameOwner => "oualid", :deckName => "toto"})
			@packet.data.should eql("KO")
		end 
	end

	
	describe "sdtu" do
		before :each do 
			@d = Deck.create(:nameOwner => "oualid", :deckName => " deck test 1 ", :isReal => false)			
			@params = { :client_name => 'oualid',
						:nameOwner => 'oualid',
				  		:deckName => ' deck test 1 ',
				  		:idCard => '12313452',
				  		:nbCard => '1',
				  		:isSided => true
				   	 }
		end 

		after :each do 
			Deck.delete_all
		end

		it "should send deck to the user " do
			@protocol.acfd(@packet, @params)
			c = Deckcard.find_by_idDeck_and_idCard(@d.idDeck, @params[:idCard])
			@packet = @protocol.sdtu(@packet, {:nameOwner => "oualid", :idDeck => @d.idDeck.to_s})
			@packet.data.should eql("idDeck\r#{@d.idDeck}\nidCard\r#{c.idCard}\nnbCard\r#{c.nbCard}\nisSided\r#{c.isSided}\n")
		end

		it "should not send deck to the user(user name doesn't exist)" do 
			@packet = @protocol.sdtu(@packet, {:nameOwner => "JCVD", :idDeck => @d.idDeck.to_s})
			@packet.data.should eql("KO")
		end

		it "should not send deck to the user (user name is missing)" do 
			@packet = @protocol.sdtu(@packet, {:idDeck => @d.idDeck})
			@packet.data.should eql("KO")
		end

		it "should not send deck to the user (idDeck doesn't exist)" do 
			@packet = @protocol.sdtu(@packet, {:nameOwner => "oualid", :idDeck => "oui"})
			@packet.data.should eql("KO")
		end

		it "should not send deck to the user (idDeck is missing)" do 
			@packet = @protocol.sdtu(@packet, {:nameOwner => "oualid"})
			@packet.data.should eql("KO")

		end


	end

	describe "glid" do 
		after :each do 
			Deck.delete_all
		end

		before :each do 
			@d = Deck.create(:nameOwner => "oualid", :deckName => " deck 2 ", :isReal => false)
		end
	
		it "should not get list od user's deck(nameOwner doesn't exist)" do 
			@packet = @protocol.glid(@packet, {:nameOwner => "JCVD"})
			@packet.data.should eql("KO")
		end

		it "should	not get list of user's deck (nameOwner is missing)" do
						@packet = @protocol.glid(@packet, {:name => "oualid"})
			@packet.data.should eql("KO")
		end

		it "should get list of user's deck" do 
			@packet = @protocol.glid(@packet, {:nameOwner => "oualid"})
			@packet.data.should eql("idDeck\r#{@d.idDeck}\ndeckName\r#{@d.deckName}\nisReal\r#{@d.isReal}\n")
		end
	end 

end