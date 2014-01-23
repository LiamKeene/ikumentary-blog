module SidebarHelper

  def grouping_navigation_links(grouping_class)
    # Groupings published articles
    links_array = grouping_class.with_articles.map do |grp|
      [grp.display_name, url_for(grp)]
    end
  end

  def category_navigation_links
    grouping_navigation_links(Category)
  end

  def tag_navigation_links
    grouping_navigation_links(Tag)
  end
end