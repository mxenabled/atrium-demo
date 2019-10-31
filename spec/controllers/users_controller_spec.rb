require 'spec_helper'

RSpec.describe UsersController, type: :controller do
  
  describe "it loads the users#show page" do
    it "loads members" do 
      @user = FactoryBot.create(:user, guid: "USR-9331248c-943c-44f7-b972-9f4305768477")
      sign_in @user
      FactoryBot.create(:member, guid: "MBR-e05a8abb-adc4-4929-9574-4d1fef21190f", user: @user, user_id: user.id)
      get :show
      expect(response.status).to eq(200)
    end 
  end 
end
