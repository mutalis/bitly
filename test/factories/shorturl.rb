FactoryGirl.define do
  factory :ShortenedUrl do
    url { Faker::Internet.url }
    unique_key { Faker::Internet.password(8) }
  end
end
