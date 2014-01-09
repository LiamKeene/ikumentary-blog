class Comment < ActiveRecord::Base
  belongs_to :article

  validates :article_id, presence: true
  validates :author,  presence: true, length: { maximum: 100 }
  validates :email,   presence: true
  validates :content, presence: true
end
