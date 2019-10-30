class InstitutionsController < ApplicationController
  #before_action :authenticate_user!

  def index
    @institutions = get_institutions
  end

private

  def get_institutions
    institution_response = client.institutions.list_institutions()
    institution_response&.institutions
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling InstitutionsApi->list_institutions: #{e}"
  end 
end
