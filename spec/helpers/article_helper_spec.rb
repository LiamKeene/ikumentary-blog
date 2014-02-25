require 'spec_helper'

describe ArticleHelper do
  
  describe 'format_published_date' do

    let(:pub_article) do
      create(:article, published_at: 'Sat, 25 Jan 2014 11:02:40 UTC +00:00')
    end
    let(:pub_date) { format_published_date(pub_article.published_at) }
      
    let(:draft_article) { create(:article, :draft) }
    let(:draft_date) { format_published_date(draft_article.published_at) }
    
    it 'formats the published_at date of an article' do
      expect(pub_date).to eq('25/01/2014')
    end

    it 'returns "Unpublished" if the article is a draft' do
      expect(draft_date).to eq('Unpublished')
    end
  end
end