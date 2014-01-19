require 'spec_helper'

describe "Article Pages" do
  let(:user) { FactoryGirl.create(:user) }
  before(:each) { sign_in(user) }

  subject { page }

  describe "index" do
    let(:articles) { FactoryGirl.create_list(:article, 5) }
    before { visit admin_articles_path }

    it { expect(page).to have_title_and_content('All Articles', 'All Articles') }

    it "should tabulate each article" do
      Article.all.each do |article|
        expect(page).to have_selector('td', text: article.title)
      end
    end
  end

  describe "new article page" do
    before { visit new_admin_article_path }

    it { expect(page).to have_title_and_content('New Article', 'New Article') }
  end

  describe "show article page" do
    let(:article) { FactoryGirl.create(:article) }
    before { visit admin_article_path(article) }

    it { expect(page).to have_title_and_content(article.title, article.title) }
  end

  describe "edit article page" do
    let(:article) { FactoryGirl.create(:article) }
    before { visit edit_admin_article_path(article) }

    it { expect(page).to have_title_and_content('Edit Article', 'Edit Article') }
  end

end