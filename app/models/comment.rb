class Comment < ActiveRecord::Base
  belongs_to :post

  validates :post_id, presence: true
  validates :author,  presence: true, length: { maximum: 100 }
  validates :email,   presence: true
  validates :content, presence: true
end
