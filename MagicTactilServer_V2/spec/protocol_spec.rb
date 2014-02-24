require 'spec_helper'

describe Protocol do
  before :each do
    @protocol = Protocol.new({}, "Mutex")
    @packet = Packet.new
    @params = {}
  end

  describe 'Protocol#call_action' do
    it 'should fail because method doesn\'t exist' do
      @protocol.call_action(:method_doesnt_exist, @packet, @params).should eql(false)
    end

    it 'should fail because method doesn\'t exist' do
      @protocol.call_action(:glid, @packet, @params).should eql(true)
    end
  end

  describe 'Protocol#serialize' do
    it 'should call serialize method' do
      @protocol.serialize({}).should eql('')
    end
  end
end