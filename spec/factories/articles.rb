FactoryBot.define do
  factory :article do
    # articleというfactoryを作った
    title { Faker::Lorem.characters(number: 10) }
    content { Faker::Lorem.characters(number: 300) }
  end
end