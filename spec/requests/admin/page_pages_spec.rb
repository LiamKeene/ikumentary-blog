require 'spec_helper'

describe "Page Pages" do
  let(:user) { FactoryGirl.create(:user) }
  before(:each) { sign_in(user) }

  subject { page }

  describe "index" do
    let(:pages) { FactoryGirl.create_list(:page, 5) }
    before { visit admin_pages_path }

    it { should have_title(full_title('All Pages')) }
    it { should have_content('All Pages') }

    it "should tabulate each page" do
      Page.all.each do |page_obj|
        expect(page).to have_selector('td', text: page_obj.title)
      end
    end
  end

  describe "new page page" do
    before { visit new_admin_page_path }

    it { should have_title(full_title('New Page')) }
    it { should have_content('New Page') }
  end

  describe "show page page" do
    let(:page_obj) { FactoryGirl.create(:page) }
    before { visit admin_page_path(page_obj) }

    it { should have_title(full_title(page_obj.title)) }
    it { should have_content(page_obj.title) }
  end

  describe "edit page page" do
    let(:page_obj) { FactoryGirl.create(:page) }
    before { visit edit_admin_page_path(page_obj) }

    it { should have_title(full_title("Edit Page")) }
    it { should have_content("Edit Page") }
  end

end