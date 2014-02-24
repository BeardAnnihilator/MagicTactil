require 'spec_helper.rb'

describe User do
  describe 'validators' do
    describe 'uniqueness' do
      it 'should fail because username already exists' do
        User.new(username: 'alex', email: 'henri@lol.com', password: 'toto4242').should_not be_valid
      end

      it 'should fail because email already exists' do
        User.new(username: 'cool', email: 'farsi_m@epitech.eu', password: 'toto4242').should_not be_valid
      end
    end

    describe 'presence' do
      it 'should fail because user is not present' do
        User.new(email: 'cool@jeans.com', password: 'toto4242').should_not be_valid
      end

      it 'should fail because email is not present' do
        User.new(username: 'cool', password: 'toto4242').should_not be_valid
      end

      it 'should fail because password is not present' do
        User.new(username: 'joe', email: 'joe@dalton.com').should_not be_valid
      end
    end

    describe 'email format validation' do
      it 'should fail because email format is wrong' do
        User.new(username: 'hello', email: 'lol@lol', password: 'toto4242').should_not be_valid
        User.new(username: 'hello', email: 'lol@lol.', password: 'toto4242').should_not be_valid
        User.new(username: 'hello', email: '@lol.fr', password: 'toto4242').should_not be_valid
        User.new(username: 'hello', email: 'je suis hetero', password: 'toto4242').should_not be_valid
      end

      it 'should success' do
        User.new(username: 'hello', email: 'zhang@ai.com', password: 'toto4242').should be_valid
      end
    end

    describe 'password length between 6 and 20 characters' do
      it 'should fail because password length is less than 6 characters' do
        User.new(username: 'hello', email: 'zhang@ai.com', password: 'toto').should_not be_valid
      end

      it 'should fail because password length is more than 20 characters' do
        User.new(username: 'hello', email: 'zhang@ai.com', password: '12345678901234567890qwerty').should_not be_valid
      end

      it 'should success because password length is between 6 and 20' do
        User.new(username: 'hello', email: 'zhang@ai.com', password: 'toto4242').should be_valid
      end
    end
  end
end