FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@email.com" }
    password 'password'
  end
end
