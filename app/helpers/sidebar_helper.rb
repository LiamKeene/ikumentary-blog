module SidebarHelper

  def grouping_navigation_links(grouping_class)
    route = grouping_class.to_s.pluralize.underscore.to_sym
    
    # Groupings published articles
    links_array = grouping_class.with_articles.map do |grp|
      {
        name: grp.display_name, 
        url: url_for(controller: route, action: :show, id: grp.name)
      }
    end
  end

  def category_navigation_links
    grouping_navigation_links(Category)
  end

  def tag_navigation_links
    grouping_navigation_links(Tag)
  end
end