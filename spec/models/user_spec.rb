require 'spec_helper'

describe User do

  before do
    @user = FactoryGirl.create(:user)
  end 

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

  it { should respond_to(:remember_token) }

  it { should respond_to(:authenticate) }

  it { should respond_to(:posts) }

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
    let(:user_with_same_email) { @user.dup }
     
      it 'should not be valid' do
        user_with_same_email.email.upcase!
        
        # Set login to another value so we know we are testing the `email` field
        user_with_same_email.login = 'Another'

        expect(user_with_same_email).to_not be_valid
      end
  end

  describe 'email address has mixed case' do
    let(:mixed_case_email) { 'usER@eXAmPle.cOM' }

    it 'should be saved as lower case' do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
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
    let(:user_with_same_login) { @user.dup }

    it 'should not be valid' do
      # Set email to another value so we know we are testing the `login` field
      user_with_same_login.email = 'another@example.com'
      
      expect(user_with_same_login).to_not be_valid
    end
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

  describe 'post associations' do
    before { @user.save }
    let!(:older_post) do
      FactoryGirl.create(:post, author: @user, created_at: 1.day.ago)
    end
    let!(:newer_post) do
      FactoryGirl.create(:post, author: @user, created_at: 1.hour.ago)
    end

    it 'should have the latest posts in descending order by created_at' do
      expect(@user.posts.latest.to_a).to eq [newer_post, older_post]
    end

    it 'should destroy associated posts' do
      posts = @user.posts.to_a
      @user.destroy

      expect(posts).not_to be_empty

      posts.each do |post|
        expect(Post.where(id: post.id)).to be_empty
      end
    end
  end

  describe "remember token" do
    before { @user.save }

    its(:remember_token) { should_not be_blank }
  end
end