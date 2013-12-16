require 'spec_helper'

describe "Comment Pages" do
  let(:user) { FactoryGirl.create(:user) }
  before(:each) { sign_in(user) }

  subject { page }

  describe "index" do
    let(:comments) { FactoryGirl.create_list(:comment, 5) }
    before { visit admin_comments_path }

    it { should have_title(full_title('All Comments')) }
    it { should have_content('All Comments') }

    it "should tabulate each comment" do
      Comment.all.each do |comment|
        expect(page).to have_selector('td', text: comment.title)
      end
    end
  end

  describe "new comment page" do
    before { visit new_admin_comment_path }

    it { should have_title(full_title('New Comment')) }
    it { should have_content('New Comment') }

    it { should_not have_selector('input[name="comment[ip_addr]"]') }
    it { should_not have_selector('input[name="comment[agent]"]') }
  end

  describe "show comment page" do
    let(:comment) { FactoryGirl.create(:comment) }
    before { visit admin_comment_path(comment) }

    it { should have_title(full_title('Comment')) }
    it { should have_content(comment.content) }
  end

  describe "edit comment page" do
    let(:comment) { FactoryGirl.create(:comment) }
    before { visit edit_admin_comment_path(comment) }

    it { should have_title(full_title("Edit Comment")) }
    it { should have_content("Edit Comment") }

    it { should have_selector('input[name="comment[ip_addr]"]') }
    it { should have_selector('input[name="comment[agent]"]') }
  end

end