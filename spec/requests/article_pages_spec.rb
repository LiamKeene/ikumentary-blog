require 'spec_helper'

describe 'Article Pages' do

  subject { page }

  describe 'index' do

    context 'with published posts' do
      let!(:posts) { FactoryGirl.create_list(:post, 5, :published) }
      before { visit articles_path }

      it { expect(page).to have_title_and_content('All Posts', '') }

      it 'lists each post' do
        Post.all.each do |post|
          expect(page).to have_selector('div', text: post.title)
        end
      end
    end

    context 'with draft posts' do
      let!(:draft) { FactoryGirl.create(:post, :draft) }      

      context 'viewed as an admin' do
        let(:user) { FactoryGirl.create(:user) }
        before do
          sign_in(user)
          visit articles_path
        end

        it 'lists draft posts' do
          expect(page).to have_selector('div', text: draft.title)
        end
      end

      context 'viewed as a public user' do
        before { visit articles_path }
        it 'does not list drafts' do
          expect(page).to_not have_selector('div', text: draft.title)
        end
      end
    end
  end

  describe 'show' do
    describe 'a post' do
      let(:post) { FactoryGirl.create(:post, :published, :allow_comments) }
      let(:post_no_comments) { FactoryGirl.create(:post, :published, :disallow_comments) }
      before { visit article_path(post) }

      it { expect(page).to have_title_and_content(post.title, post.title) }

      context 'with comments allowed' do
        before { visit article_path(post) }

        it { expect(page).to have_selector('#comment-form') }
      end

      context 'with comments not allowed' do
        before { visit article_path(post_no_comments) }

        it { expect(page).not_to have_selector('#comment-form') }
      end
    end

    describe 'a page' do
      let(:page_obj) { FactoryGirl.create(:page, :published, :allow_comments) }
      before { visit article_page_path(page_obj) }

      it { expect(page).to have_title_and_content(page_obj.title, page_obj.title) }
    end
  end
end