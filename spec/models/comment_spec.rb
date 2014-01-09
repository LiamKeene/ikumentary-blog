require 'spec_helper'

describe Comment do
  
  let(:post) { FactoryGirl.create(:post) }
  before { @comment = post.comments.build(FactoryGirl.attributes_for(:comment)) }
  
  subject { @comment }

  it { should respond_to(:article_id) }
  it { should respond_to(:author) }
  it { should respond_to(:email) }
  it { should respond_to(:url) }
  it { should respond_to(:content) }
  it { should respond_to(:ip_addr) }
  it { should respond_to(:agent) }

  it { should respond_to(:article) }
  its(:article) { should eq post }

  it { should be_valid }

  describe 'when article_id is not present' do
    before { @comment.article_id = nil }
    it { should_not be_valid }
  end

  describe 'when author is not present' do
    before { @comment.author = '' }
    it { should_not be_valid }
  end

  describe 'when author is too long' do
    before { @comment.author = 'x' * 101 }
    it { should_not be_valid }
  end

  describe 'when email is not present' do
    before { @comment.email = '' }
    it { should_not be_valid }
  end

  describe 'when content is not present' do
    before { @comment.content = '' }
    it { should_not be_valid }
  end

end
