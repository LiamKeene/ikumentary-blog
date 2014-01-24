require 'spec_helper'

describe SidebarHelper do

  describe Category, 'navigation links' do
    let(:model) { Category }
    let(:factory) { :category }
    let(:route) { :categories }

    it_behaves_like 'grouping navigation links'
  end

  describe Tag, 'navigation links' do
    let(:model) { Tag }
    let(:factory) { :tag }
    let(:route) { :tags }

    it_behaves_like 'grouping navigation links'
  end
end