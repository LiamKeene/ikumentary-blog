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
end