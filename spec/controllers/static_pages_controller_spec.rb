require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  describe "GET #home" do 

    it "renders page" do 
      get :home
      expect(response.status).to eq(200)
    end 
  end 
end