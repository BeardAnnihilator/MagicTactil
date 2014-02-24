require 'spec_helper'

describe Cards do

	before :each do 
		@protocol = Protocol.new({}, "Mutex")
		@packet = Packet.new
		@params = {:client_name => 'mick',
				  	:nameOwner => 'mick',
				  	:deckName => 'deck_one',
				  	:idCard => '12313452',
				  	:nbCard => '1',
				  	:isSided => true
				   }
	end

	describe "Add or update information of cards in a deck" do

		before :each do 
			@protocol.crdk(@packet, {:nameOwner => "mick", :deckName => "deck_one", :isReal => "false"})		
		end

		after :each do 
			Deckcard.delete_all
		end

		it "should add a card to the user deck " do
			@packet = @protocol.acfd(@packet, @params)
			@packet.data.should eql('OK')
		end

		it "should add 1 to the nbCard of of the card in the deck" do 
			@packet = @protocol.acfd(@packet, @params)
			@packet.data.should eql('OK')
		end 

		it "should not add 1 to the nbCard of the card in the deck(nbCard is missing)" do 
			@packet = @protocol.acfd(@packet, @params.except(:nbCard))
			@packet.data.should eql('KO')
		end


		it "should not add the card to the user deck(the user doesn't existe)" do 
			@params[:nameOwner] = 'JCVD'
			@packet = @protocol.acfd(@packet, @params)
			@packet.data.should eql('KO')
		end

		it "should not add the card to the user deck(the user name is missing)" do 
			@packet = @protocol.acfd(@packet, @params.except(:nameOwner))
			@packet.data.should eql('KO')
		end

		it "should not add the card to the user deck(the deck name doesn't existe)" do
			@params[:deckName] = ''
			@packet = @protocol.acfd(@packet, @params)
			@packet.data.should eql('KO')
		end

		it "should not add the card to the user deck(idCard is missing)" do 
			@packet = @protocol.acfd(@packet, @params.except(:idCard))
			@packet.data.should eql('KO')
		end

		it "should not add the card to user deck(deckName is missing)" do
			@packet = @protocol.acfd(@packet, @params.except(:deckName))
			@packet.data.should eql('KO')
		end

	end

	describe "Remove card form a deck" do

		before :each do 
			@protocol.crdk(@packet, {:nameOwner => "mick", :deckName => "deck_one", :isReal => "false"})
			params = {:client_name => 'mick',
				  	:nameOwner => 'mick',
				  	:deckName => 'deck_one',
				  	:idCard => '12313452',
				  	:nbCard => '1',
				  	:isSided => true
				   }
			@protocol.acfd(@packet, params)
		end

		after :each do 
			Deckcard.delete_all
		end

		it "should remove card form deck" do 
			@packet = @protocol.rcfd(@packet, @params)
			@packet.data.should eql('OK')
		end

		it "should not remove card form deck (nameOwner is missing)" do
			@packet = @protocol.rcfd(@packet, @params.except(:nameOwner))
			@packet.data.should eql('KO')
		end


		it "should nor remove form card deck (nameOwner doesn't exist)" do
			@params[:nameOwner] = 'JCVD'
			@packet = @protocol.rcfd(@packet, @params)
			@packet.data.should eql('KO')
		end

		it "should not remove card form deck (deckName is missing )" do 
			@packet = @protocol.rcfd(@packet, @params.except(:deckName))
			@packet.data.should eql('KO')
		end

		it "should not remove form deck (deckName doesn't exist)" do 
			@params[:deckName] = ''
			@packet = @protocol.rcfd(@packet, @params)
			@packet.data.should eql('KO')
		end

		it "should not remove card form deck (idCard is missing)" do 
			@packet = @protocol.rcfd(@packet, @params.except(:idCard))
			@packet.data.should eql('KO')	
		end

		it "should not remove card form deck (idCard doesn't exist)" do
			@params[:idCard] = ''
			@packet = @protocol.rcfd(@packet, @params)
			@packet.data.should eql('KO')
		end
	end

end