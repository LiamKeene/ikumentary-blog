require 'spec_helper'

describe "StaticPages" do

  describe "Home Page" do
    
    it "should have the content 'Ikumentary'" do
      visit '/static_pages/home'
      expect(page).to have_content('Ikumentary')
    end

    it "should have the base title" do
      visit '/static_pages/home'
      expect(page).to have_title('Ikumentary')
    end

    it "should not have a custom page title" do
      visit '/static_pages/home'
      expect(page).not_to have_title('Home |')
    end
  end

  describe "About Page" do

    it "should have the content 'About'" do
      visit '/static_pages/about'
      expect(page).to have_content('About')
    end
  
    it "should have the title 'About'" do
      visit '/static_pages/about'
      expect(page).to have_title('About | Ikumentary')
    end
  end

  describe "Contact Page" do

    it "should have the content 'Contact'" do
      visit '/static_pages/contact'
      expect(page).to have_content('Contact')
    end
  
    it "should have the title 'Contact'" do
      visit '/static_pages/contact'
      expect(page).to have_title('Contact | Ikumentary')
    end
  end
end