require 'rails_helper'

RSpec.describe ConnectionStatus, type: :model do

  it "has a valid factory" do 
    FactoryBot.create(:connection_status).should be_valid
  end 

  it "is invalid without name" do 
    FactoryBot.build(:connection_status, name: nil).should_not be_valid
  end 
end
