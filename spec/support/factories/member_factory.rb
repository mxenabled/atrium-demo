FactoryBot.define do
  factory :member do 
    institution_code { "mxbank" }
    sequence(:guid) { |n| "MBR-#{n}" }
    sequence(:user_guid) { |n| "USR-#{n}" }
    user_id { rand(1000) }
    user
    account { 
      {
        :guid => "ACT-1",
        :name => "Gringotts Checking",
        :balance => 1000
      }
    }
  end 
end