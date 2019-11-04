require 'spec_helper'

RSpec.describe MembersController, type: :controller do

  describe "GET #new" do 
    
  context "when logged in" do
      
      before(:each) do 
        @user = FactoryBot.create(:user, guid: "USR-79941373-a635-4bc3-ac52-4cddbd74d6f9")
        @member = FactoryBot.create(:member, guid: "MBR-85bbc828-3a5c-49fd-981b-0a9942617d83", user_id: @user.id)
        sign_in @user
      end 

      it  "is successful with required parameters" do 
        get :new, :params => {:institution_code => "mxbank"} 
        expect(response.status).to eq(200)
      end 

      it "raises error without required parameters" do 
        expect{get :new, :params => nil}.to raise_error(ArgumentError)
      end 
    end 
  end 

  describe "GET #edit" do 

    context "when logged in" do 

    it "sucessfully loads page" do
      get :edit, :params => {:id => @member.id}
      expect(response.status).to eq(200)
    end
  end
end