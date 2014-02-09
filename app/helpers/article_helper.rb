module ArticleHelper
  # Formats the published date of an article or returns 'Unpublished' if it is
  # a draft
  def format_published_date(date)
    !date.nil? ? date.strftime('%d/%m/%Y') : 'Unpublished'
  end
end