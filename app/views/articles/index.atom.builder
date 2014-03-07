atom_feed(url: articles_path(format: 'atom', :only_path => false)) do |feed|
  feed.title @title
  feed.updated @updated

  @articles.each do |article|
    feed.entry(article) do |entry|
      entry.title   article.title
      entry.content article.content, :type => 'html'

      entry.author do |author|
        author.name article.author.name
      end
    end
  end
end