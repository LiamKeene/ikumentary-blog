require 'spec_helper'

describe "Post Pages" do

  subject { page }

  describe "index" do
    let(:posts) { FactoryGirl.create_list(:post, 5) }
    before { visit posts_path }

    it { should have_title(full_title('All Posts')) }
    it { should have_content('All Posts') }

    it "should tabulate each post" do
      Post.all.each do |post|
        expect(page).to have_selector('td', text: post.title)
      end
    end
  end

  describe "new post page" do
    before { visit new_post_path }

    it { should have_title(full_title('New Post')) }
    it { should have_content('New Post') }
  end

  describe "show post page" do
    let(:post) { FactoryGirl.create(:post) }
    before { visit post_path(post) }

    it { should have_title(full_title(post.title)) }
    it { should have_content(post.title) }
  end

  describe "edit post page" do
    let(:post) { FactoryGirl.create(:post) }
    before { visit edit_post_path(post) }

    it { should have_title(full_title("Edit Post")) }
    it { should have_content("Edit Post") }
  end

end