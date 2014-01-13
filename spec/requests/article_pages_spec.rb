require 'spec_helper'

describe 'Article Pages' do

  subject { page }

  describe 'index' do

    context 'published posts' do
      let!(:posts) { FactoryGirl.create_list(:post, 5, :published) }
      before { visit articles_path }

      it 'lists each post' do
        Post.all.each do |post|
          expect(page).to have_selector('div', text: post.title)
        end
      end
    end

    context 'draft posts' do
      let!(:draft) { FactoryGirl.create(:post, :draft) }
      before { visit articles_path }

      it 'does not list drafts' do
        expect(page).to_not have_selector('div', text: draft.title)
      end
    end
  end

  describe 'show a post' do
    let(:post) { FactoryGirl.create(:post, :published) }
    before { visit article_path(post) }

    it { should have_title(full_title(post.title)) }
    it { should have_content(post.title) }
  end

  describe 'show a page' do
    let(:page_obj) { FactoryGirl.create(:page, :published) }
    before { visit article_page_path(page_obj) }

    it { should have_title(full_title(page_obj.title)) }
    it { should have_content(page_obj.title) }
  end
end
