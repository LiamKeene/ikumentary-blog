module SidebarHelper
  def category_navigation_links
    # Categories with published articles
    links_array = Category.with_articles.map do |category|
      [category.display_name, category_path(category.name)]
    end
  end

  def tag_navigation_links
    # Tags with published articles
    links_array = Tag.with_articles.map do |tag|
      [tag.display_name, tag_path(tag.name)]
    end
  end
end