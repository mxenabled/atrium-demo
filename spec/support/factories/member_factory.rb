FactoryBot.define do
  factory :member do 
    id { rand(1000) }
    institution_code { "mxbank" }
    sequence(:guid) { |n| "MBR-#{n}" }
    sequence(:user_guid) { |n| "USR-#{n}" }
    user_id { rand(1000) }
    user
  end 
end