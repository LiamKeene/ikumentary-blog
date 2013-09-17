require 'spec_helper'

describe Post do

  before do 
    @post = FactoryGirl.create(:post)
  end

  subject { @post }

  it { should respond_to(:title) }
  it { should respond_to(:slug) }
  it { should respond_to(:content) }
  it { should respond_to(:author_id) }
  it { should respond_to(:status) }

  it { should respond_to(:author) }
  its(:author) { should eq user }

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
    let(:post_with_same_slug) { @post.dup }

    it 'should not be valid' do
      post_with_same_slug.slug.upcase!

      expect(post_with_same_slug).to_not be_valid
    end
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
end