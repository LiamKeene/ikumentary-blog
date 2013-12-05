require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit admin_sign_in_path }

    it { should have_title(full_title('Sign In')) }
    it { should have_content('Sign In') }

    describe "with invalid information" do
      before { click_button 'Sign In' }

      it { should have_selector('div.error', text: 'Invalid') }

      describe "after visiting another page" do
        before { visit root_path }

        it { should_not have_selector('div.error') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }

      before do
        fill_in 'Login',    with: user.login
        fill_in 'Password', with: user.password
        click_button 'Sign In'
      end

      it { should have_link('Sign Out', href: admin_sign_out_path) }
      it { should_not have_link('Sign In', href: admin_sign_in_path) }
    end
  end
end