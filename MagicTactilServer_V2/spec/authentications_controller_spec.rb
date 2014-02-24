require 'spec_helper'

describe AuthenticationsController do
  before :each do
    @protocol = Protocol.new({}, 'mutex')
    @packet = Packet.new
  end

  after :each do
    user = User.find_by_email('john@doe.com')
    user.delete unless user.nil?
  end

  describe '#regu' do
    it 'should fail because username exists' do
     @packet = @protocol.regu(@packet, {username: 'alex', email: 'lol@lol.com', password: 'toto4242'})
      @packet.data.should eql('KO')
    end

    it 'should fail because email exists' do
      @packet = @protocol.regu(@packet, {username: 'jean', email: 'periph_a@epitech.eu', password: 'toto4242'})
      @packet.data.should eql('KO')
    end

    it 'should fail because password is shorter than 6 chars' do
      @packet = @protocol.regu(@packet, {username: 'hello', email: 'hello@world.fr', password: 'toto'})
      @packet.data.should eql('KO')
    end


    it 'should fail because email is not well formatted' do
      @packet = @protocol.regu(@packet, {username: 'hello', email: 'hello@world.', password: 'toto4242'})
      @packet.data.should eql('KO')
    end

    it 'should success' do
      @packet = @protocol.regu(@packet, {username: 'john doe', email: 'john@doe.com', password: 'toto4242'})
      @packet.data.should eql('OK')
    end
  end

  describe '#sgni' do
    it 'should fail sign in' do
      @packet = @protocol.sgni(@packet, {username: 'Inconnu', password: 'toto4242'})
      @packet.data.should eql('KO')
    end

    it 'should success sign in' do
      @packet = @protocol.sgni(@packet, {username: 'alex', password: '123456'})
      @packet.data.should eql('OK')
    end
  end

  describe 'sgno' do
    it 'should fail sign out' do
      @packet = @protocol.sgno(@packet, {username: 'Inconnu', email: 'email@inconnu.net'})
      @packet.data.should eql('KO')
    end

    it 'should success sign out' do
      @packet = @protocol.sgno(@packet, {email: 'periph_a@epitech.eu', username: 'alex'})
      @packet.data.should eql('OK')
    end
  end
end