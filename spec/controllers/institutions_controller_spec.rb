RSpec.describe InstitutionsController, type: :controller do
  let(:user) { ::FactoryBot.create(:user) }

  describe '#index' do 
    it "loads successfully" do 
      sign_in user 
      get :index
      expect(response.status).to eq(200)
    end

    it "redirects if not logged in" do 
      get :index
      response.should redirect_to("/users/sign_in")
    end
  end
end