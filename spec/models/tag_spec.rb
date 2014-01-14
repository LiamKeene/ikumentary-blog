require 'spec_helper'

describe Tag do
  
  before { @tag = FactoryGirl.create(:tag) }

  subject { @tag }

  it { should respond_to(:name) }
  it { should respond_to(:display_name) }

  it { should respond_to(:articles) }

  it { should be_valid }

  describe 'when display_name is not present' do
    before { @tag.display_name = '' }
    it { should_not be_valid }
  end

end
