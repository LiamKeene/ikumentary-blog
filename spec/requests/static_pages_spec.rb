require 'spec_helper'

describe "StaticPages" do

  subject { page }

  describe "Home Page" do
    before { visit root_path }
    
    it { should have_content('Ikumentary') }
    it { should have_title('Ikumentary') }
    it { should_not have_title('Home |') }
  end

  describe "About Page" do
    before { visit about_path }
    
    it { should have_content('About') }
    it { should have_title('About | Ikumentary') }
  end

  describe "Contact Page" do
    before { visit contact_path }
    
    it { should have_content('Contact') }
    it { should have_title('Contact | Ikumentary') }
  end
end