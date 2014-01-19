require 'spec_helper'

describe 'Tag Pages' do

  subject { page }

  describe 'index' do
    let(:tags) { FactoryGirl.create_list(:tag, 5) }
    before { visit admin_tags_path }

    let(:heading) { 'All Tags' }
    let(:content) { 'All Tags' }
    it_behaves_like 'Ikumentary Pages'

    it 'should tabulate each tag' do
      Tag.all.each do |tag|
        expect(page).to have_selector('td', text: tag.name)
      end
    end
  end

  describe 'new tag page' do
    before { visit new_admin_tag_path }

    let(:heading) { 'New Tag' }
    let(:content) { 'New Tag' }
    it_behaves_like 'Ikumentary Pages'
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

    let(:heading) { 'Edit Tag' }
    let(:content) { 'Edit Tag' }
    it_behaves_like 'Ikumentary Pages'
  end
end