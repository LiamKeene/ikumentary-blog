class Tag < ActiveRecord::Base

  before_save :create_tag_name

  has_and_belongs_to_many :articles, -> { order('created_at DESC') }

  validates :name, presence: true, uniqueness: true

  def create_tag_name
    if self.display_name.blank?
      self.display_name = self.name
    end
    self.name = self.display_name.to_url
  end

end
