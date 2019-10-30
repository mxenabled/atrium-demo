FactoryBot.define do
  factory :member do 
    institution_code { "mxbank" }
    sequence(:guid) { |n| "MBR-#{n}" }
    sequence(:user_guid) { |n| "USR-#{n}" }
    user_id { rand(1000) }
    user
  end 
end