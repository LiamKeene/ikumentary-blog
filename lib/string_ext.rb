class String
  # to_url returns a string that is suitable for URLs
  def to_url
    return if self.nil?

    s = self.downcase
    s.gsub!(/[^a-z0-9\-]/, '-')  # Only a-z, 0-9 and dashes allowed
    s.gsub!(/-+/, '-')           # Collapse multiple dashes to single dash
    s.gsub!(/-$/, '')            # Remove leading dashes
    s.gsub!(/^-/, '')            # Remove trailing dashes
    s
  end
end
