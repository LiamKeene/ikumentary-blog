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
      it { should have_content('Dashboard') }

      it { should have_link('Manage Users', href: admin_users_path) }
      it { should have_link('Manage Posts', href: admin_posts_path) }
      it { should have_link('Manage Comments', href: admin_comments_path) }
    end
  end
end