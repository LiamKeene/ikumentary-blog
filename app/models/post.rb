class Post < ActiveRecord::Base

  extend FriendlyId

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  friendly_id :slug, use: :slugged

  has_many :comments, dependent: :destroy

  scope :latest, -> { order('created_at DESC') }
  scope :published, -> { where('published_at < ?', Time.now).order('published_at DESC') }

  paginates_per 5

  validates :title,       presence: true, length: { maximum: 255 }
  validates :slug,        presence: true, length: { maximum: 100 }, uniqueness: { case_sensitive: false }
  validates :content,     presence: true
  validates :author_id,   presence: true
end