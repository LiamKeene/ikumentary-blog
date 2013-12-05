class User < ActiveRecord::Base
  before_create :create_remember_token
  before_save { email.downcase! }

  has_many :posts, foreign_key: 'author_id', dependent: :destroy
    
  has_secure_password

  validates :name,      presence: true, length: { maximum: 40 }
  validates :email,     presence: true, uniqueness: { case_sensitive: false }
  validates :login,     length: { minimum: 4, maximum: 40 }, uniqueness: true
  validates :password,  length: { minimum: 6 }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end