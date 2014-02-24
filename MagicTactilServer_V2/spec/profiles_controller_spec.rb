require 'spec_helper'

describe ProfilesController do
  before :each do
    @protocol = Protocol.new({}, 'Mutex')
    @packet = Packet.new
    @params = {}
  end

  describe 'get user informations (getu)' do
    it 'should return an empty string because username is missing' do
      @packet = @protocol.getu(@packet, { })
      @packet.data.should eql('')
    end

    it 'should return an empty string because username doesn\'t exist' do
      @packet = @protocol.getu(@packet, { username: 'jexiste pas' })
      @packet.data.should eql('')
    end

    it 'should success' do
      @packet = @protocol.getu(@packet, { username: 'oualid' })
      @packet.data.should_not eql('')
    end
  end

  describe 'set user informations (setu)' do
    before :each do
      @user = User.create(email: 'test@example.com', username: 'test', password: '123456')
    end

    after :each do
      @user.delete
    end

    it 'should return an empty string because username is missing' do
      @packet = @protocol.setu(@packet, { })
      @packet.data.should eql('KO')
    end

    it 'should return an empty string because username doesn\'t exist' do
      @packet = @protocol.setu(@packet, { username: 'jexiste pas' })
      @packet.data.should eql('KO')
    end

    it 'should success' do
      @packet = @protocol.setu(@packet, { username: 'oualid' })
      @packet.data.should eql('OK')
    end

    it 'should fail because email format is invalid' do
      @packet = @protocol.setu(@packet, { username: @user.username, email: 'wrong_format' })
      @packet.data.should eql('KO')
    end

    it 'should success because email format is valid' do
      @packet = @protocol.setu(@packet, { username: @user.username, email: 'format@good.fr' })
      @packet.data.should eql('OK')
    end

    it 'should success to update gender field' do
      @packet = @protocol.setu(@packet, { username: @user.username, gender: 'male' })
      @packet.data.should eql('OK')
    end

    it 'should success to update location field' do
      @packet = @protocol.setu(@packet, { username: @user.username, location: '12 rue des bonbons' })
      @packet.data.should eql('OK')
    end

    it 'should fail to update password field because length is not >= 6' do
      @packet = @protocol.setu(@packet, { username: @user.username, password: '12345' })
      @packet.data.should eql('KO')
    end

    it 'should success to update password field because length is >= 6' do
      @packet = @protocol.setu(@packet, { username: @user.username, password: '123456' })
      @packet.data.should eql('OK')
    end

    it 'should success to update telephone field' do
      @packet = @protocol.setu(@packet, { username: @user.username, telephone: '0620361922' })
      @packet.data.should eql('OK')
    end
  end
end