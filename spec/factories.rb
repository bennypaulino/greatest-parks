FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    username "boatyMcBoatface"
    first_name "Boaty"
    last_name "McBoatface"
    password "secretPassword"
    password_confirmation "secretPassword"
  end

  factory :post do
    title "A fitting name..."
    body  "for the next aircraft carrier."
    association :user
  end
end
