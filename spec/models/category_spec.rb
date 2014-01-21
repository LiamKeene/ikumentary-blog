require 'spec_helper'

describe Category do

  before { @category = FactoryGirl.create(:category) }

  subject { @category }

  it { should respond_to(:name) }
  it { should respond_to(:display_name) }

  it { should respond_to(:articles) }
  
  it { should be_valid }

  describe 'when name is not present' do
    before { @category.name = '' }
    it { should_not be_valid }
  end

  context 'category creation' do

    describe 'when display name is not specified' do
      let(:test_name) { 'Cool Stuff' }
      before do
        @category.name = test_name
        @category.display_name = ''
        @category.save
      end

      it 'copies the name to the display name' do
        expect(@category.display_name).to eq(test_name)
      end

      it 'then uses the display name to create a URL friendly name' do
        expect(@category.name).to eq(@category.display_name.to_url)
      end
    end

    describe 'capital letters and spaces are removed' do
      let(:simple_category) { FactoryGirl.create(:category, display_name: 'SimpleCategory') }
      let(:category_with_spaces) { FactoryGirl.create(:category, display_name: 'category with spaces') }

      it { expect(simple_category.name).to eq('simplecategory') }
      it { expect(category_with_spaces.name).to eq('category-with-spaces') }
    end

    describe 'categories are unique' do
      let(:category_with_same_name) { @category.dup }

      it { expect(category_with_same_name).to_not be_valid }
    end
  end

  context 'with articles' do
    # Create two published articles with same category, so we can test
    # that unique categories with articles are returned
    let(:pub_article) { FactoryGirl.create(:article, :published) }
    let(:pub_article_1) { FactoryGirl.create(:article, :published) }
    let(:draft_article) { FactoryGirl.create(:article, :draft) }
    let!(:article_category) do
      FactoryGirl.create(:category, name: 'category', 
        articles: [pub_article, pub_article_1, draft_article])
    end
    let(:empty_category) { FactoryGirl.create(:category) }

    describe '#published_articles' do
      it 'returns published articles' do
        expect(article_category.published_articles.size).to eq(2)
      end
      it 'does not return draft articles' do
        expect(article_category.published_articles).not_to include(draft_article)
      end
    end

    describe '.with_articles' do
      it 'returns unique categories with articles' do
        expect(Category.with_articles.size).to eq(1)
      end
      it 'does not return categories without articles' do
        expect(Category.with_articles).not_to include(empty_category)
      end
    end
  end
end