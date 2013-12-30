require 'spec_helper'

describe "StaticPages" do

  subject { page }

  shared_examples_for 'All Static Pages' do
    it { should have_selector('h1', text: heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "About Page" do
    before { visit about_path }
    let(:heading)     { 'About' }
    let(:page_title)  { 'About' }
    
    it_should_behave_like 'All Static Pages'
  end

  describe "Contact Page" do
    before { visit contact_path }
    let(:heading)     { 'Contact' }
    let(:page_title)  { 'Contact' }
    
    it_should_behave_like 'All Static Pages'
  end
end