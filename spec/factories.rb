FactoryGirl.define do
  factory :comment do
    # sequence(:comment_body, 1) { |n| "TROLOLOL#{n}" }
    comment_body "fusion-powered U.S.S. BoatyMcBoatface"
    association :user
    association :post
  end

  factory :user do
    sequence :email do |n|
      "fakeEmail#{n}@gmail.com"
    end
    sequence :username do |n|
      "dummyUserName#{n}"
    end
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
