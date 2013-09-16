require 'spec_helper'

describe User do

  before { @user = User.new(name: 'Example User', display_name: 'Example', 
    email: 'user@example.com', url: 'example.com', login: 'example', 
    password: 'password', user_type: 'administrator') }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:display_name) }
  it { should respond_to(:email) }
  it { should respond_to(:url) }
  it { should respond_to(:login) }
  it { should respond_to(:password) }
  it { should respond_to(:user_type) }

end