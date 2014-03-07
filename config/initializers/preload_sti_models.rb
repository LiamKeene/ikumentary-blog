# Preload Article sublcasses in development mode
if Rails.env.development?
  %w[post page].each do |c|
    require_dependency File.join("app", "models", "#{c}.rb")
  end
end