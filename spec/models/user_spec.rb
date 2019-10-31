require 'spec_helper'

RSpec.describe User, type: :model do

  it "has a valid factory" do 
    FactoryBot.create(:user).should be_valid
  end 
end
