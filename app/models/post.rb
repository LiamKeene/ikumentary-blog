class Post < ActiveRecord::Base
  validates :title,       presence: true
  validates :slug,        presence: true
  validates :content,     presence: true
  validates :author_id,   presence: true
end
