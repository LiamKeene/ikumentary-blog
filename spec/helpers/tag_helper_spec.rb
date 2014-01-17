require 'spec_helper'

describe TagHelper do

  describe 'linked_tag_list' do
    let(:first_tag) { Tag.create(name: 'first-tag', display_name: 'First Tag') }
    let(:second_tag) { Tag.create(name: 'second-tag', display_name: 'Second Tag') }
    
    it 'creates a list of links for each tag' do
      # This seems so fragile
      tag_list = '<a href="/tags/first-tag">First Tag</a>, <a href="/tags/second-tag">Second Tag</a>'
      
      expect(linked_tag_list([first_tag, second_tag])).to eq(tag_list)
    end
  end
end