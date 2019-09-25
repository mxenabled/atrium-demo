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

  def create
    @institution = Institution.new(institution_params)

    respond_to do |format|
      if @institution.save
        format.html { redirect_to @institution, notice: 'Institution was successfully created.' }
        format.json { render :show, status: :created, location: @institution }
      else
        format.html { render :new }
        format.json { render json: @institution.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @institution.destroy
    respond_to do |format|
      format.html { redirect_to institutions_url, notice: 'Institution was successfully destroyed.' }
      format.json { head :no_content }
    end
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
        puts "Exception when calling InstitutionsApi->list_institutions: #{e}"
      end
    end 
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def institution_params
      params.require(:institution).permit(:code, :name)
    end
end
