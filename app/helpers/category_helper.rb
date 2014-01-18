module CategoryHelper
  def linked_category_list(categories)
    raw categories.map { |category| link_to(category.display_name, category_path(category.name)) }.join(', ')
  end
end
