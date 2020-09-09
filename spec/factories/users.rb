FactoryBot.define do
  factory :user do
    # userというfactoryを作った
    email { Faker::Internet.email }
    password { 'password' }
    trait :with_profile do
      after :build do |user|
        build(:profile, user: user)
      end
    end
    # trait機能 userの中のplofileも一緒に作る
    # userが作られた後にbuildされる
  end
end