require 'spec_helper'

describe "User Pages" do
  let(:user) { FactoryGirl.create(:user) }
  before(:each) { sign_in(user) }

  subject { page }

  describe "index" do
    let(:users) { FactoryGirl.create_list(:user, 5) }
    before { visit admin_users_path }

    let(:heading) { 'All Users' }
    let(:content) { 'All Users' }
    it_behaves_like 'Ikumentary Pages'

    it "should tabulate each user" do
      User.all.each do |user|
        expect(page).to have_selector('td', text: user.name)
      end
    end
  end

  describe "new user page" do
    before { visit new_admin_user_path }

    let(:heading) { 'New User' }
    let(:content) { 'New User' }
    it_behaves_like 'Ikumentary Pages'
  end

  describe "show user page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit admin_user_path(user) }

    it { should have_title(full_title(user.name)) }
    it { should have_content(user.name) }
  end

  describe "edit user page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_admin_user_path(user) }

    let(:heading) { 'Edit User' }
    let(:content) { 'Edit User' }
    it_behaves_like 'Ikumentary Pages'
  end

end