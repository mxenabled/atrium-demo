require 'rails_helper'

RSpec.describe ConnectionStatus, type: :model do
  
  describe '#name' do 
    it { should validate_presence_of(:name) }
  end 
end
