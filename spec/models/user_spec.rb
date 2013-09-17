require 'spec_helper'

describe User do

  before { @user = User.new(name: 'Example User', display_name: 'Example', 
    email: 'user@example.com', url: 'example.com', login: 'example', 
    password: 'password', password_confirmation: 'password', 
    user_type: 'administrator') }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:display_name) }
  it { should respond_to(:email) }
  it { should respond_to(:url) }
  it { should respond_to(:login) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:user_type) }

  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe 'when name is not present' do
    before { @user.name = '' }
    it { should_not be_valid }
  end

  describe 'when name is too long' do
    before { @user.name = 'x' * 101 }
    it { should_not be_valid }
  end

  describe 'when email is not present' do
    before { @user.email = '' }
    it { should_not be_valid }
  end

  describe 'when email is already in use' do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email.upcase!
      # Set login to another value so we know we are testing the `email` field
      user_with_same_email.login = 'Another'
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe 'when login is too short' do
    before { @user.login = 'x' * 2 }
    it { should_not be_valid }
  end

  describe 'when login is too long' do
    before { @user.login = 'x' * 41 }
    it { should_not be_valid }
  end

  describe 'when login is already in use' do
    before do
      user_with_same_login = @user.dup
      # Set email to another value so we know we are testing the `login` field
      user_with_same_login.email = 'another@example.com'
      user_with_same_login.save
    end

    it { should_not be_valid }
  end

  describe 'when password is not present' do
    before do 
      @user.password = ''
      @user.password_confirmation = ''
    end

    it { should_not be_valid }
  end

  describe 'when password is too short' do
    before { @user.password = 'x' * 5 }
    it { should_not be_valid }
  end

  describe 'when password doesn\'t match confirmation' do
    before { @user.password_confirmation = 'mismatch' }
    it { should_not be_valid }
  end

  describe 'return value of authenticate method' do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe 'with valid password' do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe 'with invalid password' do
      let(:user_for_invalid_password) { found_user.authenticate('invalid') }
       it { should_not eq user_for_invalid_password }
       specify { expect(user_for_invalid_password).to be_false }
     end
  end

end