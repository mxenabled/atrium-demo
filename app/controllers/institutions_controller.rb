class InstitutionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @response = get_institutions
    @institutions = @response.institutions
  end

private

  def get_institutions
    response = client.institutions.list_institutions()
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling InstitutionsApi->list_institutions: #{e}"
  end 
  
  def institution_params
    params.require(:institution).permit(:code, :name)
  end
end
