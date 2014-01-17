require 'spec_helper'

describe String do
  describe 'to_url' do
    # These specs are verbose, but since the to_url function uses a series
    # of gsub calls, they should be tested in isolation

    it 'does nothing when string is empty' do
      expect(''.to_url).to eq('')
    end

    it 'downcases capital letters' do
      expect('StriNg'.to_url).to eq('string')
    end

    it 'replaces spaces with dashes' do
      expect('silly string '.to_url).to eq('silly-string')
    end

    it 'removes leading dashes' do
      expect('--silly'.to_url).to eq('silly')
    end

    it 'removes trailing dashes' do
      expect('silly-'.to_url).to eq('silly')
    end

    it 'returns the same string if it is URL friendly' do
      expect('some-string'.to_url).to eq('some-string')
    end
  end
end
