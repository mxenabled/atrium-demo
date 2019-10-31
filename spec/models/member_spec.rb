require 'spec_helper'

RSpec.describe Member, type: :model do

  it "has a valid factory" do 
    FactoryBot.create(:member).should be_valid
  end
end
