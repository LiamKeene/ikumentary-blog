require 'spec_helper'

describe "Comment Pages" do

  subject { page }

  describe "index" do
    let(:comments) { FactoryGirl.create_list(:comment, 5) }
    before { visit comments_path }

    it { should have_title(full_title('All Comments')) }
    it { should have_content('All Comments') }

    it "should tabulate each comment" do
      Comment.all.each do |comment|
        expect(page).to have_selector('td', text: comment.title)
      end
    end
  end

  describe "new comment page" do
    before { visit new_comment_path }

    it { should have_title(full_title('New Comment')) }
    it { should have_content('New Comment') }
  end

  describe "show comment page" do
    let(:comment) { FactoryGirl.create(:comment) }
    before { visit comment_path(comment) }

    it { should have_title(full_title('Comment')) }
    it { should have_content('Comment') }
  end

  describe "edit comment page" do
    let(:comment) { FactoryGirl.create(:comment) }
    before { visit edit_comment_path(comment) }

    it { should have_title(full_title("Edit Comment")) }
    it { should have_content("Edit Comment") }
  end

end