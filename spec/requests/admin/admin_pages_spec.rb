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

      it { expect(page).to have_title_and_content('Dashboard', 'Dashboard') }

      it { should have_link('Manage Users', href: admin_users_path) }
      it { should have_link('Manage Articles', href: admin_articles_path) }
      it { should have_link('Manage Comments', href: admin_comments_path) }
    end
  end
end