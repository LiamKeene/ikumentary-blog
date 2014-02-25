module ArticleHelper
  # Formats the published date of an article or returns 'Unpublished' if it is
  # a draft
  def format_published_date(date, format = '%d/%m/%Y')
    !date.nil? ? date.strftime(format) : 'Unpublished'
  end
  # Formats the published date of an article according to the specs laid out
  # for the `datetime` attribute of the HTML5 time element.  If the article is
  # a draft and empty string is returned
  def format_html5_time(date)
    !date.nil? ? date.strftime('%Y-%m-%d %H:%M:%S%z') : ''
  end
end