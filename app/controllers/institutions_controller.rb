class InstitutionsController < ApplicationController
  #before_action :set_institution, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @institutions = Institution.all
  end

  def list
    @response = get_institutions
    @institutions = @response.institutions
  end 

  def new
    @institutions = get_institutions
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_institution
      @institution = Institution.find(params[:id])
    end

    def get_institutions
      api_key = Rails.application.credentials.dig(:mx_api_key)
      client_id = Rails.application.credentials.dig(:mx_client_id)
      client = Atrium::AtriumClient.new("#{api_key}", "#{client_id}")
      begin
        #List institutions
        response = client.institutions.list_institutions()
        p response
      rescue Atrium::ApiError => e
        Rails.logger.info "Exception when calling InstitutionsApi->list_institutions: #{e}"
      end
    end 
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def institution_params
      params.require(:institution).permit(:code, :name)
    end
end
