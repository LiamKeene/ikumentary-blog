class Tag < ActiveRecord::Base

  has_and_belongs_to_many :articles, -> { order('created_at DESC') }

  validates :display_name,  presence: true, uniqueness: true

end
