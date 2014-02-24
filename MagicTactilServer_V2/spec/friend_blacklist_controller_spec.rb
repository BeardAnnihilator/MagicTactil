require 'spec_helper'

describe FriendBlacklistsController do
  
  before :each do
    @protocol = Protocol.new({}, "Mutex")
    @packet = Packet.new
    @params = {}
  end

  after :each do
    Friendblacklist.delete_all
  end

  describe 'Add friend (adfr)' do
    it 'should not add new record because username is missing' do
      @packet = @protocol.adfr(@packet, { belongsto: 'alex' })
      @packet.data.should eql('KO')
    end

    it 'should not add new record because belongsto is missing' do
      @packet = @protocol.adfr(@packet, { username: 'alex' })
      @packet.data.should eql('KO')
    end

    it 'should not add new record because username doesn\'t exist' do
      @packet = @protocol.adfr(@packet, { 
        username: 'jexiste pas', belongsto: 'alex' })
      @packet.data.should eql('KO')
    end

    it 'should not add new record because belongs_to doesn\'t exist' do
      @packet = @protocol.adfr(@packet, { 
        username: 'alex', belongsto: 'jexiste pas' })
      @packet.data.should eql('KO')
    end

    it 'should not add new record because user is already a friend' do
      Friendblacklist.create(username: 'alex', belongsto: 'mehdi', typelist: 'F')
      @packet = @protocol.adfr(@packet, {
        username: 'alex', belongsto: 'mehdi' })
      @packet.data.should eql('KO')
    end

    it 'should add new record' do
      @packet = @protocol.adfr(@packet, {
        username: 'alex', belongsto: 'mehdi' })
      @packet.data.should eql('OK')
    end
  end

  describe 'Delete friend (delf)' do
    it 'should not delete record because username is missing' do
      @packet = @protocol.delf(@packet, { belongsto: 'alex' })
      @packet.data.should eql('KO')
    end

    it 'should not delete record because belongsto is missing' do
      @packet = @protocol.delf(@packet, { username: 'alex' })
      @packet.data.should eql('KO')
    end

    it 'should not delete record because username doesn\'t exist' do
      @packet = @protocol.delf(@packet, { 
        username: 'jexiste pas', belongsto: 'alex' })
      @packet.data.should eql('KO')
    end

    it 'should not delete record because belongs_to doesn\'t exist' do
      @packet = @protocol.delf(@packet, { 
        username: 'alex', belongsto: 'jexiste pas' })
      @packet.data.should eql('KO')
    end

    it 'should not delete record because there is no friendship between users' do
      @packet = @protocol.delf(@packet, {
        username: 'alex', belongsto: 'mehdi' })
      @packet.data.should eql('KO')
    end

    it 'should delete record' do
      Friendblacklist.create(username: 'alex', belongsto: 'mehdi')
      @packet = @protocol.delf(@packet, {
        username: 'alex', belongsto: 'mehdi' })
      @packet.data.should eql('OK')
    end
  end

  describe 'Add user to blacklist (adbl)' do
    it 'should not add new record because username is missing' do
      @packet = @protocol.adbl(@packet, { belongsto: 'alex' })
      @packet.data.should eql('KO')
    end

    it 'should not add new record because belongsto is missing' do
      @packet = @protocol.adbl(@packet, { username: 'alex' })
      @packet.data.should eql('KO')
    end

    it 'should not add new record because username doesn\'t exist' do
      @packet = @protocol.adbl(@packet, { 
        username: 'jexiste pas', belongsto: 'alex' })
      @packet.data.should eql('KO')
    end

    it 'should not add new record because belongs_to doesn\'t exist' do
      @packet = @protocol.adbl(@packet, { 
        username: 'alex', belongsto: 'jexiste pas' })
      @packet.data.should eql('KO')
    end

    it 'should not add new record because user is already a in blacklist' do
      Friendblacklist.create(username: 'alex', belongsto: 'mehdi', typelist: 'B')
      @packet = @protocol.adbl(@packet, {
        username: 'alex', belongsto: 'mehdi' })
      @packet.data.should eql('KO')
    end

    it 'should add new record' do
      @packet = @protocol.adbl(@packet, {
        username: 'alex', belongsto: 'mehdi' })
      @packet.data.should eql('OK')
    end
  end

  describe 'Delete friend (delf)' do
    it 'should not delete record because username is missing' do
      @packet = @protocol.delf(@packet, { belongsto: 'alex' })
      @packet.data.should eql('KO')
    end

    it 'should not delete record because belongsto is missing' do
      @packet = @protocol.debl(@packet, { username: 'alex' })
      @packet.data.should eql('KO')
    end

    it 'should not delete record because username doesn\'t exist' do
      @packet = @protocol.debl(@packet, { 
        username: 'jexiste pas', belongsto: 'alex' })
      @packet.data.should eql('KO')
    end

    it 'should not delete record because belongs_to doesn\'t exist' do
      @packet = @protocol.debl(@packet, { 
        username: 'alex', belongsto: 'jexiste pas' })
      @packet.data.should eql('KO')
    end

    it 'should not delete record because there is no friendship between users' do
      @packet = @protocol.debl(@packet, {
        username: 'alex', belongsto: 'mehdi' })
      @packet.data.should eql('KO')
    end

    it 'should delete record' do
      Friendblacklist.create(username: 'alex', belongsto: 'mehdi')
      @packet = @protocol.debl(@packet, {
        username: 'alex', belongsto: 'mehdi' })
      @packet.data.should eql('OK')
    end
  end

  describe 'Get friend list (gfrl)' do
    before :each do
      Friendblacklist.create(username: 'benjamin', belongsto: 'mehdi', typelist: 'F')
      Friendblacklist.create(username: 'benjamin', belongsto: 'alex', typelist: 'F')
      Friendblacklist.create(username: 'benjamin', belongsto: 'mickael', typelist: 'F')
      Friendblacklist.create(username: 'benjamin', belongsto: 'lucas', typelist: 'F')
    end

    it 'should return an empty string because username is missing' do
      @packet = @protocol.gfrl(@packet, { })
      @packet.data.should eql('')
    end

    it 'should return an empty string because username doesn\'t exist' do
      @packet = @protocol.gfrl(@packet, { username: 'jexiste pas' })
      @packet.data.should eql('')
    end

    it 'should return a string that contain all friends' do
      @packet = @protocol.gfrl(@packet, { username: 'benjamin' })
      @packet.data.should eql("mehdi\nalex\nmickael\nlucas\n")
    end
  end

  describe 'Get black list (gtbl)' do
    before :each do
      Friendblacklist.create(username: 'benjamin', belongsto: 'mehdi', typelist: 'B')
      Friendblacklist.create(username: 'benjamin', belongsto: 'alex', typelist: 'B')
      Friendblacklist.create(username: 'benjamin', belongsto: 'mickael', typelist: 'B')
      Friendblacklist.create(username: 'benjamin', belongsto: 'lucas', typelist: 'B')
    end

    it 'should return an empty string because username is missing' do
      @packet = @protocol.gtbl(@packet, { })
      @packet.data.should eql('')
    end

    it 'should return an empty string because username doesn\'t exist' do
      @packet = @protocol.gtbl(@packet, { username: 'jexiste pas' })
      @packet.data.should eql('')
    end

    it 'should return a string that contain the blacklist' do
      @packet = @protocol.gtbl(@packet, { username: 'benjamin' })
      @packet.data.should eql("mehdi\nalex\nmickael\nlucas\n")
    end
  end

end