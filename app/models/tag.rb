class Tag < ActiveRecord::Base

  validates :display_name,  presence: true, uniqueness: true

end
