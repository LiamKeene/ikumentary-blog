FactoryGirl.define do
  factory :user, aliases: [:author] do
    sequence(:name)         { |n| "Example User #{n}" }
    sequence(:display_name) { |n| "User #{n}" }
    sequence(:email)        { |n| "user_#{n}@example.com" }
    url 'example.com'
    sequence(:login)        { |n| "user_#{n}" }
    password 'password'
    password_confirmation 'password'
    user_type 'administrator'
  end

  factory :post do
    sequence(:title)        { |n| "Post #{n}" }
    sequence(:slug)         { |n| "post-#{n}" }
    sequence(:content)      { |n| "This is the content of post #{n}" }
    author
    sequence(:published_at) { |n| Time.now - n.days }
  end

  factory :comment do
    post
    sequence(:author)       { |n| "Author #{n}" }
    sequence(:email)        { |n| "author_#{n}@example.com" }
    sequence(:url)          { |n| "author_#{n}.example.com" }
    sequence(:content)      { |n| "This is the content of comment #{n}" }
    sequence(:ip_addr)      { |n| "12#{n}.12.34.#{n}#{n}#{n}"}
    agent                   { ['Chrome', 'Firefox', 'Safari'].sample }
  end
end
