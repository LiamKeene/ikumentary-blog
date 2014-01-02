require 'spec_helper'

describe Post do

  let(:user) { FactoryGirl.create(:user) }
  before { @post = user.posts.build(FactoryGirl.attributes_for(:post)) }

  subject { @post }

  it { should respond_to(:title) }
  it { should respond_to(:slug) }
  it { should respond_to(:content) }
  it { should respond_to(:author_id) }
  it { should respond_to(:published_at) }

  it { should respond_to(:author) }
  its(:author) { should eq user }

  it { should respond_to(:comments) }

  it { should be_valid }

  describe 'when title is not present' do
    before { @post.title = '' }
    it { should_not be_valid }
  end

  describe 'when title is too long' do
    before { @post.title = 'x' * 256 }
    it { should_not be_valid }
  end

  describe 'when slug is not present' do
    before { @post.slug = '' }
    it { should_not be_valid }
  end

  describe 'when slug is too long' do
    before { @post.slug = 'x' * 101 }
    it { should_not be_valid }
  end

  describe 'when slug has mixed case' do
    before do
      post_with_mixed_case_slug = @post.dup
      post_with_mixed_case_slug.slug = 'First-Posting'
      post_with_mixed_case_slug.save
    end

    it { should be_valid }
  end

  describe 'when content is not present' do
    before { @post.content = '' }
    it { should_not be_valid }
  end

  describe 'when author_id is not present' do
    before { @post.author_id = nil }
    it { should_not be_valid }
  end

  describe 'comment associations' do
    before { @post.save }
    let!(:older_comment) do
      FactoryGirl.create(:comment, post: @post, created_at: 1.day.ago)
    end
    let!(:newer_comment) do
      FactoryGirl.create(:comment, post: @post, created_at: 1.hour.ago)
    end

    it 'should destroy associated comments' do
      comments = @post.comments.to_a
      @post.destroy

      expect(comments).not_to be_empty

      comments.each do |comment|
        expect(Comment.where(id: comment.id)).to be_empty
      end
    end
  end
end