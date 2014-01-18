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

    describe 'categorys are unique' do
      let(:category_with_same_name) { @category.dup }

      it { expect(category_with_same_name).to_not be_valid }
    end
  end

  describe '#published_articles' do
    let(:published_article) { FactoryGirl.create(:article, :published) }
    let(:draft_article) { FactoryGirl.create(:article, :draft) }
    let(:article_category) do
      FactoryGirl.create(:category, name: 'category', 
        articles: [published_article, draft_article])
    end
    it 'only returns published articles' do
      expect(article_category.published_articles.size).to eq(1)
    end
  end
end