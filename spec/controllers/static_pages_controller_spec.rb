require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  let(:user) { ::FactoryBot.create(:user) }

  describe "GET #home" do 
    context "when user hits page" do 
      it "renders page if not logged in" do 
        get :home
        expect(response.status).to eq(200)
      end 

      it "redirects to members#index if logged in" do 
        sign_in user
        get :home
        response.should redirect_to '/members/index'
      end 
    end 
  end
end