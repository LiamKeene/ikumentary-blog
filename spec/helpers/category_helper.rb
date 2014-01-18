require 'spec_helper'

describe CategoryHelper do

  describe 'linked_category_list' do
    let(:first_category) { Category.create(name: 'first-category', display_name: 'First Category') }
    let(:second_category) { Category.create(name: 'second-category', display_name: 'Second Category') }
    
    it 'creates a list of links for each category' do
      # This seems so fragile
      category_list = '<a href="/categories/first-category">First Category</a>, <a href="/categories/second-category">Second Category</a>'
      
      expect(linked_category_list([first_category, second_category])).to eq(category_list)
    end
  end
end
