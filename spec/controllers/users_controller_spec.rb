require 'spec_helper'

RSpec.describe UsersController, type: :controller do
  
  describe "GET users#show" do
    it "loads members" do 
      @user = FactoryBot.create(:user, guid: "USR-79941373-a635-4bc3-ac52-4cddbd74d6f9")
      sign_in @user
      FactoryBot.create(:member, guid: "MBR-85bbc828-3a5c-49fd-981b-0a9942617d83", user_id: @user.id)
      get :show, :params => {:id => @user.id}
      expect(response.status).to eq(200)
    end 
  end 
end
