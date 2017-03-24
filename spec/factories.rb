FactoryGirl.define do
  factory :comment do
    sequence(:comment_body, 1) { |n| "TROLOLOL#{n}" }
  end

  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    sequence(:username, 1) { |n| "boatyMcBoatface#{n}" }
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
