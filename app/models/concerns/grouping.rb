# Concerns for grouping models, Category and Tag, which share a lot of common code  
module Grouping
  
  extend ActiveSupport::Concern

  included do
    # Groupings need consistent naming
    before_save :create_name

    # Groupings have and belongs to many Articles
    has_and_belongs_to_many :articles, -> { order('created_at DESC') }

    # Scope to return unique Groupings that contain Articles
    scope :with_articles, -> { joins(:articles).uniq }

    # Groupings all have the :name sttribute
    validates :name, presence: true, uniqueness: true
  end

  # Create grouping name from display name
  def create_name
    if self.display_name.blank?
      self.display_name = self.name
    end
    self.name = self.display_name.to_url
  end

  # Returns associated published articles
  def published_articles
    articles.published
  end
end