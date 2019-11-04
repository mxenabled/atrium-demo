FactoryBot.define do 
  factory :user do 
    sequence(:email) { |n| "person#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    sequence(:guid) { |n| "USR-#{n}" }
  end 
end 