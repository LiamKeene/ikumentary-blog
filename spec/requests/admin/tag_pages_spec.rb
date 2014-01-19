require 'spec_helper'

describe 'Tag Pages' do

  subject { page }

  describe 'index' do
    let(:tags) { FactoryGirl.create_list(:tag, 5) }
    before { visit admin_tags_path }

    it { expect(page).to have_title_and_content('All Tags', 'All Tags') }

    it 'should tabulate each tag' do
      Tag.all.each do |tag|
        expect(page).to have_selector('td', text: tag.name)
      end
    end
  end

  describe 'new tag page' do
    before { visit new_admin_tag_path }

    it { expect(page).to have_title_and_content('New Tag', 'New Tag') }
  end

  describe 'show tag page' do
    let(:tag) { FactoryGirl.create(:tag) }
    before { visit admin_tag_path(tag) }

    it { expect(page).to have_title_and_content(tag.name, tag.name) }
  end

  describe 'edit user page' do
    let(:tag) { FactoryGirl.create(:tag) }
    before { visit edit_admin_tag_path(tag) }

    it { expect(page).to have_title_and_content('Edit Tag', 'Edit Tag') }
  end
end