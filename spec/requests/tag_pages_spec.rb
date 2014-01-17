require 'spec_helper'

describe 'Tag Pages' do

  subject { page }

  describe 'index' do
    let!(:tags) { FactoryGirl.create_list(:tag, 5) }

    before { visit tags_path }

    it 'lists all tags' do
      expect(page).to have_selector('h1', 'All Tags')

      Tag.all.each do |tag|
        expect(page).to have_link(tag.display_name, href: tag_path(tag.name))
      end
    end
  end

  describe 'show a tag' do
    let(:tag) { FactoryGirl.create(:tag, name: 'cool-stuff', display_name: 'Cool Stuff') }
    let(:articles) { FactoryGirl.create_list(:article, 2, :published) }
    let(:extra_articles) { FactoryGirl.create_list(:article, 10, :published) }
    let(:draft) { FactoryGirl.create(:article, :draft) }

    before do
      tag.articles << articles
      tag.articles << draft
      visit tag_path(tag.name)
    end

    it { expect(page).to have_selector('h1', text: tag.display_name) }

    it 'lists published articles tagged with "cool-stuff"' do
      articles.each do |art|
        expect(page).to have_selector('div', text: art.title)
      end
    end

    it 'does not list draft articles tagged with "cool-stuff"' do
      expect(page).not_to have_selector('h2', text: draft.title)
    end

    it 'paginates tagged articles' do
      tag.articles << extra_articles
      visit tag_path(tag.name)
      
      expect(page).to have_selector('nav.pagination')
    end
  end
end