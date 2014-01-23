require 'spec_helper'

describe SidebarHelper do

  describe 'category_navigation_links' do
    let(:ham) { create(:category, name: 'ham', display_name: 'Ham') }
    let(:spam) { create(:category, name: 'spam', display_name: 'Spam') }
    let(:eggs) { create(:category, name: 'eggs', display_name: 'Eggs') }

    let(:pub_art1) { create(:article, :published) }
    let(:pub_art2) { create(:article, :published) }
    let(:pub_art3) { create(:article, :published) }
    
    let(:expected_links) { [] }
    let(:actual_links) { category_navigation_links }

    before do
      # Assign articles
      ham.articles << pub_art1
      spam.articles << pub_art2
      eggs.articles << pub_art3

      expected_links.append(
        [ham.display_name, category_path(ham.name)]
      ).append(
        [spam.display_name, category_path(spam.name)]
      ).append(
        [eggs.display_name, category_path(eggs.name)]
      )
    end

    it 'returns an array of URL name and path hashes' do
      expect(actual_links).to eq(expected_links)
    end
  end

  describe 'tag_navigation_links' do
    let(:ham) { create(:tag, name: 'ham', display_name: 'Ham') }
    let(:spam) { create(:tag, name: 'spam', display_name: 'Spam') }
    let(:eggs) { create(:tag, name: 'eggs', display_name: 'Eggs') }

    let(:pub_art1) { create(:article, :published) }
    let(:pub_art2) { create(:article, :published) }
    let(:pub_art3) { create(:article, :published) }
    
    let(:expected_links) { [] }
    let(:actual_links) { tag_navigation_links }

    before do
      # Assign articles
      ham.articles << pub_art1
      spam.articles << pub_art2
      eggs.articles << pub_art3

      expected_links.append(
        [ham.display_name, tag_path(ham.name)]
      ).append(
        [spam.display_name, tag_path(spam.name)]
      ).append(
        [eggs.display_name, tag_path(eggs.name)]
      )
    end

    it 'returns an array of URL name and path hashes' do
      expect(actual_links).to eq(expected_links)
    end
  end
end