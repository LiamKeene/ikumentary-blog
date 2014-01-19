require 'spec_helper'

describe "Article Pages" do
  let(:user) { FactoryGirl.create(:user) }
  before(:each) { sign_in(user) }

  subject { page }

  describe "index" do
    let(:articles) { FactoryGirl.create_list(:article, 5) }
    before { visit admin_articles_path }

    let(:heading) { 'All Articles' }
    let(:content) { 'All Articles' }
    it_behaves_like 'Ikumentary Pages'

    it "should tabulate each article" do
      Article.all.each do |article|
        expect(page).to have_selector('td', text: article.title)
      end
    end
  end

  describe "new article page" do
    before { visit new_admin_article_path }

    let(:heading) { 'New Article' }
    let(:content) { 'New Article' }
    it_behaves_like 'Ikumentary Pages'
  end

  describe "show article page" do
    let(:article) { FactoryGirl.create(:article) }
    before { visit admin_article_path(article) }

    it { should have_title(full_title(article.title)) }
    it { should have_content(article.title) }
  end

  describe "edit article page" do
    let(:article) { FactoryGirl.create(:article) }
    before { visit edit_admin_article_path(article) }

    let(:heading) { 'Edit Article' }
    let(:content) { 'Edit Article' }
    it_behaves_like 'Ikumentary Pages'
  end

end