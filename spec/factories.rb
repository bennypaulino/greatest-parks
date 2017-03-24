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
end
