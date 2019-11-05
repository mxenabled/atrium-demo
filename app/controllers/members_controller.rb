class MembersController < ApplicationController
  before_action :authenticate_user!

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

  def destroy
    delete_member(member_guid)
    @member = Member.find(member_params[:id])
    @member.destroy
    redirect_to '/members/index'
  end

  def edit
    @institution_credentials = list_member_credentials(member_guid)
    @form_url = "/members/#{member_params[:id]}"
    @method = :patch
  end

  def index 
    @members ||= members_body(current_user.members.all)
  end 

  def new 
    @institution_code = member_params[:institution_code]
    @institution_credentials = get_institution_credentials(@institution_code)
    @form_url = '/members'
  end 

  def show
    @member = Member.find(member_params[:id])
    member_status = read_member_status(@member.guid)
    @connection_status = ConnectionStatus.find_by_name(member_status.connection_status)
  end 

  def update
    updated_credentials = credentials_to_array(member_params[:credentials].to_h)
    update_member_credentials(member_guid, updated_credentials)
    aggregate_member(member_guid)
    redirect_to members_path
  end
  
private 

  def accounts_body(member_guid)
    accounts = get_member_accounts(member_guid)
    accounts.map do |account|
      {
        :guid => account.guid,
        :name => account.name,
        :balance => account.balance
      }
    end 
  end 

  def create_atrium_member(institution_code, credentials)
    member_info = {:member => {:institution_code => institution_code, :credentials => credentials, :skip_aggregation => false}}
    body = Atrium::MemberCreateRequestBody.new(member_info)
    member_response = client.members.create_member(current_user.guid, body)
    member_response&.member
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling MembersApi->create_member: #{e}"
  end 

  def delete_member(member_guid)
    client.members.delete_member(member_guid, current_user.guid)
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling MembersApi->delete_member: #{e}"
  end

  def get_institution_credentials(institution_code)
    institution_credentials_response = client.institutions.read_institution_credentials(institution_code)
    institution_credentials_response&.credentials
rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling InstitutionsApi->read_institution_credentials: #{e}"
end

  def list_member_credentials(member_guid)
    credentials_response = client.members.list_member_credentials(member_guid, current_user.guid)
    credentials_response&.credentials
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling MembersApi->list_member_credentials: #{e}"
  end

  def members_body(members)
    members.map do |member|
      member_status = read_member_status(member.guid)
      institution = read_institution(member.institution_code)
      accounts = accounts_body(member.guid)
      { :member => {
        :member_guid => member.guid,
        :id => member.id,
        :institution_name => institution.name,
        :institution_logo => institution.small_logo_url,
        :connection_status => member_status.connection_status,
        :accounts => accounts
        }
      }
    end
  end

  def member_guid
    get_member_guid(member_params[:id])
  end 

  def member_params
    params.permit(:member_guid, :institution_code, :id, :authenticity_token, :commit, :_method, :institution_name, :institution_logo, credentials: {})
  end 

  def update_member_credentials(member_guid, credentials)
    member_body = {:member => {:credentials => credentials}}
    opts = {body: Atrium::MemberUpdateRequestBody.new(member_body)}
    update_credentials_response = client.members.update_member(member_guid, current_user.guid, opts)
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling MembersApi->update_member: #{e}"
  end
end 
