require 'spec_helper'

describe SidebarHelper do

  describe Category, 'navigation links' do
    let(:model) { Category }
    let(:factory) { :category }

    it_behaves_like 'grouping navigation links'
  end

  describe Tag, 'navigation links' do
    let(:model) { Tag }
    let(:factory) { :tag }

    it_behaves_like 'grouping navigation links'
  end
end