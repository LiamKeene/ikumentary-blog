module SidebarHelper
  def category_navigation_links
    # Categories with published articles
    links_array = Category.with_articles.map do |category|
      [category.display_name, category_path(category.name)]
    end
  end
end