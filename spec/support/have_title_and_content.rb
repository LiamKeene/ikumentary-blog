# Matcher that checks if a page has_title and has_content
RSpec::Matchers.define :have_title_and_content do |title, content|
  match do |page|
    @errors = {}

    # Assigns errors to hash as required
    @error_prefix = "#{page} expected "
    @errors[:title] = "\#has_title?(\"#{title}\") to return true, got false" unless page.has_title?(title)
    @errors[:content] = "\#has_content?(\"#{content}\") to return true, got false" unless page.has_content?(content)

    @errors.empty?
  end

  failure_message_for_should do |page|
    message = "#{@error_prefix} \n#{@errors.values.join("\n")}" unless @errors.empty?
  end

  # failure_message_for_should_not is not implemented

  description do
    message = "have title \"#{title}\" and content \"#{content}\""
  end
end