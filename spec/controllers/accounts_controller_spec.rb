require 'rails_helper'

RSpec.describe AccountsController, type: :controller do

  let(:user) { ::FactoryBot.create(:user, guid: "USR-9331248c-943c-44f7-b972-9f4305768477") }
  let(:member) { ::FactoryBot.create(:member, user: user) }
  let(:account_guid) { "ACT-3a638ba7-bf30-4353-992e-deb5a934aee6" }

  describe "GET #show" do
    it "returns http success" do
      sign_in user
      get :show, :params => {:id => member.id, :account_guid => account_guid}
      expect(response).to have_http_status(:success)
    end
  end
end
