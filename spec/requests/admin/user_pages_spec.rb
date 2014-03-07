require 'spec_helper'

describe "User Pages" do
  let(:user) { FactoryGirl.create(:user) }
  before(:each) { sign_in(user) }

  subject { page }

  describe "index" do
    let(:users) { FactoryGirl.create_list(:user, 5) }
    before { visit admin_users_path }

    it { expect(page).to have_title_and_content('All Users', 'All Users') }

    it "should tabulate each user" do
      User.all.each do |user|
        expect(page).to have_selector('td', text: user.name)
      end
    end
  end

  describe "new user page" do
    before { visit new_admin_user_path }

    it { expect(page).to have_title_and_content('New User', 'New User') }
  end

  describe "show user page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit admin_user_path(user) }

    it { expect(page).to have_title_and_content(user.name, user.name) }
  end

  describe "edit user page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_admin_user_path(user) }

    it { expect(page).to have_title_and_content('Edit User', 'Edit User') }
  end

end