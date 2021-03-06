require 'spec_helper'

describe 'Category Pages' do

  subject { page }

  describe 'index' do
    let(:categories) { FactoryGirl.create_list(:category, 5) }
    
    it { expect(page).to have_title_and_content('All Categories', 'All Categories') }

    before { visit categories_path }

    it 'lists all categories' do

      Tag.all.each do |category|
        expect(page).to have_link(category.display_name, href: category_path(category.name))
      end
    end
  end

  describe 'show a category' do
    let(:category) { FactoryGirl.create(:category, name: 'cool-stuff', display_name: 'Cool Stuff') }
    let(:articles) { FactoryGirl.create_list(:article, 2, :published) }
    let(:extra_articles) { FactoryGirl.create_list(:article, 10, :published) }
    let(:draft) { FactoryGirl.create(:article, :draft) }

    it { expect(page).to have_title_and_content(category.display_name, category.display_name) }

    before do
      category.articles << articles
      category.articles << draft
      visit category_path(category.name)
    end

    it 'lists published articles categorised under "cool-stuff"' do
      articles.each do |art|
        expect(page).to have_selector('div', text: art.title)
      end
    end

    it 'does not list draft articles categorised under "cool-stuff"' do
      expect(page).not_to have_selector('h2', text: draft.title)
    end

    it 'paginates categorised articles' do
      category.articles << extra_articles
      visit category_path(category.name)
      
      expect(page).to have_selector('nav.pagination')
    end
  end
end