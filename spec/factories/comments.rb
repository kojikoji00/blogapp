FactoryBot.define do
  factory :comment do
    # commentsというfactoryを作った
    content { Faker::Lorem.characters(number: 300) }
  end
  end