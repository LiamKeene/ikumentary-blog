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

  factory :article do
    sequence(:title)        { |n| "Article #{n}" }
    sequence(:slug)         { |n| "article-#{n}" }
    sequence(:content)      { |n| "This is the content of article #{n}" }
    author
    allow_comments true

    factory :post, class: 'Post' do
      type 'Post'
    end

    factory :page, class: 'Page' do
      type 'Page'
    end

    trait :draft do
      published_at nil
    end

    trait :published do
      sequence(:published_at) { |n| Time.now - n.days }
    end

    trait :allow_comments do
      allow_comments true
    end

    trait :disallow_comments do
      allow_comments false
    end
  end

  factory :comment do
    article
    sequence(:author)       { |n| "Author #{n}" }
    sequence(:email)        { |n| "author_#{n}@example.com" }
    sequence(:url)          { |n| "author_#{n}.example.com" }
    sequence(:content)      { |n| "This is the content of comment #{n}" }
    sequence(:ip_addr)      { |n| "12#{n}.12.34.#{n}#{n}#{n}"}
    agent                   { ['Chrome', 'Firefox', 'Safari'].sample }
  end

  factory :category do
    sequence(:name)         { |n| "category-#{n}" }
    sequence(:display_name) { |n| "Category #{n}" }
  end

  factory :tag do
    sequence(:name)         { |n| "tag-#{n}" }
    sequence(:display_name) { |n| "Tag #{n}" }
  end
end
