require 'spec_helper'

describe UrlHelper do

  describe 'when url includes protocol' do

    it 'returns the url' do
      expect(url_with_protocol('http://some.site.com')).to eq('http://some.site.com')
    end
  end
  
  describe 'when url is missing protocol' do

    it 'adds the http protocol' do
      expect(url_with_protocol('some.site.com')).to eq('http://some.site.com')
    end
  end
end