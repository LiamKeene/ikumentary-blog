module TagHelper
  def linked_tag_list(tags)
    raw tags.map { |tag| link_to(tag.display_name, tag_path(tag.name)) }.join(', ')
  end
end