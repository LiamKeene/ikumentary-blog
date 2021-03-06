require 'spec_helper'

describe Article do

  let(:user) { FactoryGirl.create(:user) }
  before { @article = user.articles.build(FactoryGirl.attributes_for(:article)) }

  subject { @article }

  it { should respond_to(:title) }
  it { should respond_to(:slug) }
  it { should respond_to(:content) }
  it { should respond_to(:extract) }
  it { should respond_to(:author_id) }
  it { should respond_to(:published_at) }

  it { should respond_to(:author) }
  its(:author) { should eq user }

  it { should respond_to(:allow_comments) }
  it { should respond_to(:allow_comments?) }
  it { should respond_to(:comments) }

  it { should respond_to(:categories) }
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

  describe 'when extract contains HTML' do
    before do
      @article.extract = '<p>Nasty HTML</p>'
      @article.save
    end
  
    it { expect(@article.extract).to eq('Nasty HTML') }
  end

  describe 'when author_id is not present' do
    before { @article.author_id = nil }
    it { should_not be_valid }
  end

  describe 'when allow_comments is not present' do
    before { @article.allow_comments = nil }
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

  describe 'category associations' do
    let!(:first_category) { FactoryGirl.create(:category, name: 'first') }
    let!(:second_category) { FactoryGirl.create(:category, name: 'second') }
    before do
      @article.categories << first_category
      @article.categories << second_category
      @article.save
    end

    it 'articles can be categorised' do
      expect(@article.categories.count).to eq(2)
      expect(@article.categories.sort_by(&:id)).to eq([first_category, second_category].sort_by(&:id))
    end

    it 'does not destroy categories when deleted' do
      categories = @article.categories
      @article.destroy
      expect(categories).to be_empty

      categories.each do |category|
        expect(Category.where(id: category.id)).not_to be_empty
      end
    end

    context 'when no categories are specified when saved' do
      before do
        @article.categories = []
      end

      context 'and when the category: Uncategorised exists' do
        before do
          # Ensure that the `Uncategorised` Category exists
          Category.find_by_name('uncategorised') || create(:category, name: 'uncategorised')

          @article.save
        end
        
        it 'assigns the category' do
          expect(@article.categories.size).to eq(1)
          expect(@article.categories.first.name).to eq('uncategorised')
        end
      end

      context 'and when the category: Uncategorised doesn\'t exist' do
        before do
          # Ensure that the `Uncategorised` Category does not exist
          Category.find_by_name('uncategorised').destroy

          @article.save
        end

        it 'creates the category and assigns it' do
          expect(Category.exists?(name: 'uncategorised')).to be(1)
          expect(@article.categories.size).to eq(1)
          expect(@article.categories.first.name).to eq('uncategorised')
        end
      end
    end
  end

  describe 'tag associations' do
    let!(:first_tag) { FactoryGirl.create(:tag, name: 'first') }
    let!(:second_tag) { FactoryGirl.create(:tag, name: 'second') }
    before do
      @article.tags << first_tag
      @article.tags << second_tag
      @article.save
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

  describe '#published' do
    let!(:pub_article) { FactoryGirl.create(:article, :published) }
    let!(:draft_article) { FactoryGirl.create(:article, :draft) }

    it { expect(Article.published.size).to eq(1) }
  end

  context '#next and #previous methods' do
    let!(:art_1) { create(:post, :published, published_at: Time.now - 1.day) }
    let!(:art_2) { create(:post, :draft) }
    let!(:art_3) { create(:page, :published, published_at: Time.now - 1.hour) }
    let!(:art_4) { create(:post, :published, published_at: Time.now) }

    describe '#next' do
      it 'skips drafts and Pages' do
        expect(art_1.next).to eq(art_4)
      end
      it { expect(art_4.next).to eq(nil) }

      context 'with include_pages option' do
        it { expect(art_1.next({include_pages: true})).to eq(art_3) }
        it { expect(art_3.next({include_pages: true})).to eq(art_4) }
      end
    end

    describe '#previous' do
      it { expect(art_1.previous).to eq(nil) }
      it 'skips drafts and Pages' do
        expect(art_4.previous).to eq(art_1)
      end

      context 'with include_pages option' do
        it { expect(art_4.previous({include_pages: true})).to eq(art_3) }
        it { expect(art_3.previous({include_pages: true})).to eq(art_1) }
      end
    end
  end

  describe '#get_extract' do
    let(:has_extract) { create(:article, content: 'Some short content', extract: 'Check this out') }
    let(:no_extract) { create(:article, content: 'No extract here') }
    let(:has_html) { create(:article, content: '<p>HTML tags begone!</p>') }
    
    it { expect(has_extract.get_extract).to eq(has_extract.extract) }
    it { expect(no_extract.get_extract).to eq(no_extract.content) }
    it { expect(has_html.get_extract).to eq('HTML tags begone!') }
  end
end
