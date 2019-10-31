FactoryBot.define do
  factory :connection_status do 
    name { "CHALLENGED" }
    message { "You have a pending MFA challenge" }
  end 
end