require 'spec_helper'

describe "Admin Dashboard" do

  let(:user) { FactoryGirl.create(:user) }
  subject { page }

  describe "when accessed" do

    describe "by non logged in user" do
      before { visit admin_path }

      its(:current_path) { should eq admin_sign_in_path }
    end

    describe "by logged in user" do
      before do
        visit admin_path
        sign_in(user)
      end

      it { should have_title(full_title('Dashboard')) }
    end
  end
end