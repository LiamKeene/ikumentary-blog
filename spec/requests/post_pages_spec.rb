require 'spec_helper'

describe "Post Pages" do

  subject { page }

  describe "index" do
    let(:posts) { FactoryGirl.create_list(:post, 10) }
    before { visit posts_path }

    it "should list each post" do
      Post.all.each do |post|
        expect(page).to have_selector('div', text: post.title)
      end
    end
  end

  describe "show post page" do
    let(:post) { FactoryGirl.create(:post) }
    before { visit post_path(post) }

    it { should have_title(full_title(post.title)) }
    it { should have_content(post.title) }
  end
end