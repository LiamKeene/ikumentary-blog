class Post < ActiveRecord::Base
  validates :title,       presence: true, length: { maximum: 255 }
  validates :slug,        presence: true, length: { maximum: 100 }, uniqueness: true
  validates :content,     presence: true
  validates :author_id,   presence: true
end
