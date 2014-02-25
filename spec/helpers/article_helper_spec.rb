require 'spec_helper'

describe ArticleHelper do

  let(:pub_article) { create(:article, published_at: 'Sat, 25 Jan 2014 11:02:40 UTC +00:00') }
  let(:draft_article) { create(:article, :draft) }
  
  describe 'format_published_date' do
    let(:pub_date) { format_published_date(pub_article.published_at) }
    let(:pub_date_1) { format_published_date(pub_article.published_at, '%B %d, %Y') }
    let(:draft_date) { format_published_date(draft_article.published_at) }
    
    context 'when no format is given' do
      it 'formats the date using the %d/%m/%Y format' do
        expect(pub_date).to eq('25/01/2014')
      end
    end

    context 'when a format is given' do
      it 'formats the date of an article using the given format' do
        expect(pub_date_1).to eq('January 25, 2014')
      end
    end

    it 'returns "Unpublished" if the article is a draft' do
      expect(draft_date).to eq('Unpublished')
    end
  end

  describe 'format_html5_time' do
    let(:pub_date) { format_html5_time(pub_article.published_at) }
    let(:draft_date) { format_html5_time(draft_article.published_at) }

    it 'formats the published_at date to HTML5 time element spec' do
      expect(pub_date).to eq('2014-01-25 11:02:40+0000')
    end

    # HTML5 spec has a very strict subset of allowed times
    it 'returns an empty string if the article us a draft' do
      expect(draft_date).to eq('')
    end
  end
end