require 'spec_helper'

describe Post do

  before { @post = Post.new(title: 'First Post', slug: 'first-post', 
    content: 'This is the content of the first post', 
    author_id: 1, status: 'Published') }

  subject { @post }

  it { should respond_to(:title) }
  it { should respond_to(:slug) }
  it { should respond_to(:content) }
  it { should respond_to(:author_id) }
  it { should respond_to(:status) }

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

  describe 'when slug is already in use' do
    before do
      post_with_same_slug = @post.dup
      post_with_same_slug.save
    end

    it { should_not be_valid }
  end

  describe 'when content is not present' do
    before { @post.content = '' }
    it { should_not be_valid }
  end

  describe 'when author_id is not present' do
    before { @post.author_id = nil }
    it { should_not be_valid }
  end
end