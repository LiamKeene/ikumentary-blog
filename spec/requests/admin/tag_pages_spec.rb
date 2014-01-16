require 'spec_helper'

describe 'Tag Pages' do

  subject { page }

  describe 'index' do
    let(:tags) { FactoryGirl.create_list(:tag, 5) }
    before { visit admin_tags_path }

    it { should have_title(full_title('All Tags')) }
    it { should have_content('All Tags') }

    it 'should tabulate each tag' do
      Tag.all.each do |tag|
        expect(page).to have_selector('td', text: tag.name)
      end
    end
  end

  describe 'new tag page' do
    before { visit new_admin_tag_path }

    it { should have_title(full_title('New Tag')) }
    it { should have_content('New Tag') }
  end

  describe 'show tag page' do
    let(:tag) { FactoryGirl.create(:tag) }
    before { visit admin_tag_path(tag) }

    it { should have_title(full_title(tag.name)) }
    it { should have_content(tag.name) }
  end

  describe 'edit user page' do
    let(:tag) { FactoryGirl.create(:tag) }
    before { visit edit_admin_tag_path(tag) }

    it { should have_title(full_title('Edit Tag')) }
    it { should have_content('Edit Tag') }
  end
end