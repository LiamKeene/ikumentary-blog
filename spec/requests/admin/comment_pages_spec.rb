require 'spec_helper'

describe "Comment Pages" do
  let(:user) { FactoryGirl.create(:user) }
  before(:each) { sign_in(user) }

  subject { page }

  describe "index" do
    let(:comments) { FactoryGirl.create_list(:comment, 5) }
    before { visit admin_comments_path }

    let(:heading) { 'All Comments' }
    let(:content) { 'All Comments' }
    it_behaves_like 'Ikumentary Pages'

    it "should tabulate each comment" do
      Comment.all.each do |comment|
        expect(page).to have_selector('td', text: comment.title)
      end
    end
  end

  describe "new comment page" do
    before { visit new_admin_comment_path }

    let(:heading) { 'New Comment' }
    let(:content) { 'New Comment' }
    it_behaves_like 'Ikumentary Pages'

    it { should_not have_selector('input[name="comment[ip_addr]"]') }
    it { should_not have_selector('input[name="comment[agent]"]') }
  end

  describe "show comment page" do
    let(:comment) { FactoryGirl.create(:comment) }
    before { visit admin_comment_path(comment) }

    let(:heading) { 'Comment' }
    let(:content) { comment.content }
    it_behaves_like 'Ikumentary Pages'
  end

  describe "edit comment page" do
    let(:comment) { FactoryGirl.create(:comment) }
    before { visit edit_admin_comment_path(comment) }

    let(:heading) { 'Edit Comment' }
    let(:content) { 'Edit Comment' }
    it_behaves_like 'Ikumentary Pages'

    it { should have_selector('input[name="comment[ip_addr]"]') }
    it { should have_selector('input[name="comment[agent]"]') }
  end

end