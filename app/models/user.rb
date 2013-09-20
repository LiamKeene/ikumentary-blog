class User < ActiveRecord::Base
  before_save { email.downcase! }

  has_many :posts, foreign_key: 'author_id', dependent: :destroy
    
  has_secure_password

  validates :name,      presence: true, length: { maximum: 40 }
  validates :email,     presence: true, uniqueness: { case_sensitive: false }
  validates :login,     length: { minimum: 4, maximum: 40 }, uniqueness: true
  validates :password,  length: { minimum: 6 }
end
