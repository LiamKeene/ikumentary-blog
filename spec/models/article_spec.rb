require 'spec_helper'

describe Article do

  let(:user) { FactoryGirl.create(:user) }
  before { @article = user.articles.build(FactoryGirl.attributes_for(:article)) }

  subject { @article }

  it { should respond_to(:title) }
  it { should respond_to(:slug) }
  it { should respond_to(:content) }
  it { should respond_to(:author_id) }
  it { should respond_to(:published_at) }

  it { should respond_to(:author) }
  its(:author) { should eq user }

  it { should respond_to(:comments) }

  it { should respond_to(:tags) }

  it { should be_valid }

  describe 'when title is not present' do
    before { @article.title = '' }
    it { should_not be_valid }
  end

  describe 'when title is too long' do
    before { @article.title = 'x' * 256 }
    it { should_not be_valid }
  end

  describe 'when slug is not present' do
    before { @article.slug = '' }
    it { should_not be_valid }
  end

  describe 'when slug is too long' do
    before { @article.slug = 'x' * 101 }
    it { should_not be_valid }
  end

  describe 'when slug has mixed case' do
    before do
      article_with_mixed_case_slug = @article.dup
      article_with_mixed_case_slug.slug = 'First-Posting'
      article_with_mixed_case_slug.save
    end

    it { should be_valid }
  end

  describe 'when content is not present' do
    before { @article.content = '' }
    it { should_not be_valid }
  end

  describe 'when author_id is not present' do
    before { @article.author_id = nil }
    it { should_not be_valid }
  end

  describe 'comment associations' do
    before { @article.save }
    let!(:older_comment) do
      FactoryGirl.create(:comment, article: @article, created_at: 1.day.ago)
    end
    let!(:newer_comment) do
      FactoryGirl.create(:comment, article: @article, created_at: 1.hour.ago)
    end

    it 'should destroy associated comments' do
      comments = @article.comments.to_a
      @article.destroy

      expect(comments).not_to be_empty

      comments.each do |comment|
        expect(Comment.where(id: comment.id)).to be_empty
      end
    end
  end

  describe 'tag associations' do
    let!(:first_tag) { FactoryGirl.create(:tag, name: 'first') }
    let!(:second_tag) { FactoryGirl.create(:tag, name: 'second') }
    before do
      @article.save
      @article.tags << first_tag
      @article.tags << second_tag
      @article.reload
    end

    it 'articles can be tagged' do
      expect(@article.tags.count).to eq(2)
      expect(@article.tags.sort_by(&:id)).to eq([first_tag, second_tag].sort_by(&:id))
    end

    it 'does not destroy tags when deleted' do
      tags = @article.tags
      @article.destroy
      expect(tags).to be_empty

      tags.each do |tag|
        expect(Tag.where(id: tag.id)).not_to be_empty
      end
    end
  end
end
