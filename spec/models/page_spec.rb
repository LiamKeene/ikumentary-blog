require 'spec_helper'

describe Page do

  let(:user) { FactoryGirl.create(:user) }
  before { @page = user.articles.build(FactoryGirl.attributes_for(:page)) }

  subject { @page }

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
    before { @page.title = '' }
    it { should_not be_valid }
  end

  describe 'when title is too long' do
    before { @page.title = 'x' * 256 }
    it { should_not be_valid }
  end

  describe 'when slug is not present' do
    before { @page.slug = '' }
    it { should_not be_valid }
  end

  describe 'when slug is too long' do
    before { @page.slug = 'x' * 101 }
    it { should_not be_valid }
  end

  describe 'when slug has mixed case' do
    before do
      page_with_mixed_case_slug = @page.dup
      page_with_mixed_case_slug.slug = 'First-Posting'
      page_with_mixed_case_slug.save
    end

    it { should be_valid }
  end

  describe 'when content is not present' do
    before { @page.content = '' }
    it { should_not be_valid }
  end

  describe 'when author_id is not present' do
    before { @page.author_id = nil }
    it { should_not be_valid }
  end

  describe 'comment associations' do
    before { @page.save }
    let!(:older_comment) do
      FactoryGirl.create(:comment, article: @page, created_at: 1.day.ago)
    end
    let!(:newer_comment) do
      FactoryGirl.create(:comment, article: @page, created_at: 1.hour.ago)
    end

    it 'should destroy associated comments' do
      comments = @page.comments.to_a
      @page.destroy

      expect(comments).not_to be_empty

      comments.each do |comment|
        expect(Comment.where(id: comment.id)).to be_empty
      end
    end
  end
end