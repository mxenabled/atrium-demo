class MembersController < ApplicationController
  before_action :authenticate_user!

  def new 
    @institution_code = member_params[:institution_code]
    @institution_credentials = get_institution_credentials(@institution_code)
    @form_url = '/members'
  end 

  def create
    member_credentials = credentials_to_array(member_params[:credentials].to_h)
    atrium_member = create_atrium_member(member_params[:institution_code], member_credentials)
    member = Member.from_atrium_member(atrium_member, current_user.id)
    if member.save!
      redirect_to registrations_edit_path(:id => member.id)
    else  
      redirect_to '/institutions'
    end         
  end 

  def show
    member_status = read_member_status(member_guid)
    @connection_status = ConnectionStatus.find_by_name(member_status.connection_status)
  end 
  
private 

  def create_atrium_member(institution_code, credentials)
    member_info = {:member => {:institution_code => institution_code, :credentials => credentials, :skip_aggregation => false}}
    body = Atrium::MemberCreateRequestBody.new(member_info)
    member_response = client.members.create_member(current_user.guid, body)
    member_response&.member
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling MembersApi->create_member: #{e}"
  end 

  def get_institution_credentials(institution_code)
    institution_credentials_response = client.institutions.read_institution_credentials(institution_code)
    institution_credentials_response&.credentials
rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling InstitutionsApi->read_institution_credentials: #{e}"
end

  def member_guid
    get_member_guid(member_params[:id])
  end 

  def member_params
    params.permit(:member_guid, :institution_code, :id, :authenticity_token, :commit, :_method, :institution_name, :institution_logo, credentials: {})
  end 
end 
