class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :name,      presence: true, length: { maximum: 40 }
  validates :email,     presence: true, uniqueness: { case_sensitive: false }
  validates :login,     length: { minimum: 4, maximum: 40 }, uniqueness: true
  
  has_secure_password
end
