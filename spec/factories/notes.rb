FactoryBot.define do
  factory :note do
    association :user, factory: :user
    title 'Title'
    body 'Body'
  end
end
