require 'spec_helper'

shared_examples_for 'a Grouping model' do
  include_context 'subject class'

  describe 'responds to certain attributes' do
    let(:grouping) { create(factory) }
    it { expect(grouping).to respond_to(:name) }
    it { expect(grouping).to respond_to(:display_name) }

    it { expect(grouping).to respond_to(:articles) }

    it { expect(grouping).to be_valid }
  
    describe 'when name is not present' do
      before { grouping.name = '' }
      it { expect(grouping).not_to be_valid }
    end
  end

  describe 'when the display name is not given' do
    let(:name) { 'Cool Stuff' }
    let(:grouping) { build(factory, name: name, display_name: '') }
    before { grouping.save }

    it 'copies the name to the display name' do
      expect(grouping.display_name).to eq(name)
    end
    it 'uses the display name to create a URL friendly name' do
      expect(grouping.name).to eq(grouping.display_name.to_url)
    end
  end

  describe 'when a grouping is saved' do
    let(:grouping) { create(factory, display_name: 'Simple') }
    let(:grouping_w_spaces) { create(factory, display_name: 'has spaces') }
    let(:grouping_w_same_name) { grouping.dup }
    
    it 'removes capital letters and spaces' do
      expect(grouping.name).to eq('simple')
      expect(grouping_w_spaces.name).to eq('has-spaces')
    end
    it 'ensures the name is unique' do
      expect(grouping_w_same_name).to_not be_valid
    end
  end

  context 'with articles' do
    let(:pub_articles) do
      [
        create(:article, :published),
        create(:article, :published)
      ]
    end
    let(:draft_article) { create(:article, :draft) }
  
    let!(:grouping) do
      create(factory, name: 'grouping', 
        articles: pub_articles << draft_article)
    end
    let(:empty_grouping) { create(factory) }

    describe '#published_articles' do

      it 'returns published articles' do
        expect(grouping.published_articles.size).to eq(2)
      end
      it 'does not return draft articles' do
        expect(grouping.published_articles).not_to include(draft_article)
      end
    end

    describe '.with_articles' do
      it 'returns unique groupings with articles' do
        expect(model.with_articles.size).to eq(1)
      end
      it 'does not return groupings without articles' do
        expect(model.with_articles).not_to include(empty_grouping)
      end
    end
  end
end