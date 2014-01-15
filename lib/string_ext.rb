class String
  # to_url returns a string that is suitable for URLs
  def to_url
    return if self.nil?

    s = self.downcase
    s.gsub!(/\s/, '-')
  end
end
