class UsersController < ApplicationController
  before_action :authenticate_user!

  def create
    @atrium_user = create_atrium_user
    current_user.update_attribute(:guid, @atrium_user.guid)
    redirect_to :action => "index", :controller => "institutions"
  end 

  def show
    @members ||= members_body(current_user.members.all)
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

  def create_atrium_user
    userInfo = {:user => {:identifier => SecureRandom.uuid}}
    body = Atrium::UserCreateRequestBody.new(userInfo) 
    atrium_user = client.users.create_user(body)
    atrium_user&.user
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling UsersApi->create_user: #{e}"
  end 

  def get_member_accounts(member_guid)
    accounts_response = client.members.list_member_accounts(member_guid, current_user.guid)
    accounts_response&.accounts
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling MembersApi->list_member_accounts: #{e}"
  end 

  def read_institution(institution_code)
    institution_response = client.institutions.read_institution(institution_code)
    institution_response&.institution
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling InstitutionsApi->read_institution: #{e}"
  end
  
  def members_body(members)
    members.map do |member|
      institution = read_institution(member.institution_code)
      accounts = accounts_body(member.guid)
      { :member => {
        :member_guid => member.guid,
        :institution_name => institution.name,
        :institution_logo => institution.small_logo_url,
        :accounts => accounts
        }
      }
    end 
  end 
end 