FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password do
      Faker::Internet.password(min_length: 8, mix_case: true, special_characters: true)
    end

    trait :acrivated do
      acrivated { true }
    end

    factory :activated_user, traits: %i[acrivated]
  end
end
