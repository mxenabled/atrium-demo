RSpec.describe InstitutionsController, type: :controller do
  let(:user) { ::FactoryBot.create(:user) }

  describe '#index' do 
    it "loads successfully" do 
      sign_in user 
      get :index
      expect(response).to have_http_status(200)
    end 
  end 
end 