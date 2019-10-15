class UsersController < ApplicationController
  before_action :authenticate_user!

  def create
    if current_user.guid.nil?
    @atrium_user = create_atrium_user
    current_user.update_attribute(:guid, @atrium_user.guid)
    redirect_to :action => "index", :controller => "institutions"
    else 
      redirect_to :action => "show", :id => current_user.id
    end 
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
  
  def members_body(members)
    members.map do |member|
      member_status = read_member_status(member.guid)
      institution = read_institution(member.institution_code)
      accounts = accounts_body(member.guid)
      { :member => {
        :member_guid => member.guid,
        :member_id => member.id,
        :institution_name => institution.name,
        :institution_logo => institution.small_logo_url,
        :connection_status => member_status.connection_status,
        :accounts => accounts
        }
      }
    end 
  end 
end 