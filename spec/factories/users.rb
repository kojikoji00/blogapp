FactoryBot.define do
  factory :user do
    # userというfactoryを作った
      email { Faker::Internet.email }
      password { 'password' }
    end
end