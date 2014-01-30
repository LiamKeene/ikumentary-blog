class Article < ActiveRecord::Base

  DEFAULT_LIMIT = 5

  extend FriendlyId

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  friendly_id :slug, use: :slugged

  has_many :comments, dependent: :destroy

  has_and_belongs_to_many :categories
  has_and_belongs_to_many :tags

  paginates_per DEFAULT_LIMIT

  scope :latest, -> { order('created_at DESC') }
  scope :published, -> { where('published_at < ?', Time.now).order('published_at DESC') }
  scope :recent, -> { published.limit(DEFAULT_LIMIT) }

  validates :title,       presence: true, length: { maximum: 255 }
  validates :slug,        presence: true, length: { maximum: 100 }, uniqueness: { case_sensitive: false }
  validates :content,     presence: true
  validates :author_id,   presence: true
  
  validates_inclusion_of :allow_comments, in: [true, false]

  # Sets the model_name of each child to that of the parent (Article)
  # We do this so that child models will use the articles_controller, without 
  # setting up individual routes
  def self.inherited(child)
    child.instance_eval do
      alias :original_model_name :model_name
      def model_name
        Article.model_name
      end
    end
    super
  end

  # Creates an array of descendant classes, used for form select fields
  def self.select_options
    descendants.map { |c| c.to_s }.sort
  end

  def allow_comments?
    allow_comments
  end
end