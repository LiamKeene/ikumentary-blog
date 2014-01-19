require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit admin_sign_in_path }

    let(:heading) { 'Sign In' }
    let(:content) { 'Sign In' }
    it_behaves_like 'Ikumentary Pages'

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

      before { sign_in(user) }

      it { should have_link('dashboard', href: admin_path) }
      it { should have_link('sign out', href: admin_sign_out_path) }
      it { should_not have_link('sign in', href: admin_sign_in_path) }
    end
  end
end