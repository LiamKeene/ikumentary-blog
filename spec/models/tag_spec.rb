require 'spec_helper'

describe Tag do

  before { @tag = FactoryGirl.create(:tag) }

  subject { @tag }

  it { should respond_to(:name) }
  it { should respond_to(:display_name) }

  it { should respond_to(:articles) }
  
  it { should be_valid }

  describe 'when name is not present' do
    before { @tag.name = '' }
    it { should_not be_valid }
  end

  context 'tag creation' do

    describe 'when display name is not specified' do
      let(:test_name) { 'Cool Stuff' }
      before do
        @tag.name = test_name
        @tag.display_name = ''
        @tag.save
      end

      it 'copies the name to the display name' do
        expect(@tag.display_name).to eq(test_name)
      end

      it 'then uses the display name to create a URL friendly name' do
        expect(@tag.name).to eq(@tag.display_name.to_url)
      end
    end

    describe 'capital letters and spaces are removed' do
      let(:simple_tag) { FactoryGirl.create(:tag, display_name: 'SimpleTag') }
      let(:tag_with_spaces) { FactoryGirl.create(:tag, display_name: 'tag with spaces') }

      it { expect(simple_tag.name).to eq('simpletag') }
      it { expect(tag_with_spaces.name).to eq('tag-with-spaces') }
    end

    describe 'tags are unique' do
      let(:tag_with_same_name) { @tag.dup }

      it { expect(tag_with_same_name).to_not be_valid }
    end
  end

  context 'with articles' do
    # Create two published articles with same tag, so we can test
    # that unique tags with articles are returned
    let(:pub_article) { FactoryGirl.create(:article, :published) }
    let(:pub_article_1) { FactoryGirl.create(:article, :published) }
    let(:draft_article) { FactoryGirl.create(:article, :draft) }
    let!(:article_tag) do
      FactoryGirl.create(:tag, name: 'tag', 
        articles: [pub_article, pub_article_1, draft_article])
    end
    let(:empty_tag) { FactoryGirl.create(:tag) }

    describe '#published_articles' do
      it 'returns published articles' do
        expect(article_tag.published_articles.size).to eq(2)
      end
      it 'does not return draft articles' do
        expect(article_tag.published_articles).not_to include(draft_article)
      end
    end

    describe '.with_articles' do
      it 'returns unique tags with articles' do
        expect(Tag.with_articles.size).to eq(1)
      end
      it 'does not return tags without articles' do
        expect(Tag.with_articles).not_to include(empty_tag)
      end
    end
  end
end