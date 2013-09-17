FactoryGirl.define do
  factory :user do
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
    author_id 1
    status 'Published'
  end
end