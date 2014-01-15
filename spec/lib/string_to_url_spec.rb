require 'spec_helper'

describe String do
  describe 'to_url' do
    it 'replaces spaces and capitals with a dash' do
      expect('Some string'.to_url).to eq('some-string')
    end
  end
end
