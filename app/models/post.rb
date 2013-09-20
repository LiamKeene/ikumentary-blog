class Post < ActiveRecord::Base
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  scope :latest, -> { order('created_at DESC') }
  
  validates :title,       presence: true, length: { maximum: 255 }
  validates :slug,        presence: true, length: { maximum: 100 }, uniqueness: { case_sensitive: false }
  validates :content,     presence: true
  validates :author_id,   presence: true
end