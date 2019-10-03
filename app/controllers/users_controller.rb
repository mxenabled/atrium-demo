class UsersController < ApplicationController
  before_action :authenticate_user!

    def create
      @response = create_atrium_user
      @atrium_user_guid = @response.user.guid
      current_user.update_attribute(:guid, @atrium_user_guid)
      redirect_to :action => "index", :controller => "institutions"
    end 

    def show
      @accounts = get_user_accounts
      @members = current_user.members.all.to_a
    end 

    def registration_path
      if current_user.guid.nil? || current_user.members.nil? 
        redirect_to 'users#create'
      else 
        redirect_to 'users#show'
      end 
    end 

  private 

  def create_atrium_user
    userInfo = {:user => {:identifier => SecureRandom.uuid}}
    body = Atrium::UserCreateRequestBody.new(userInfo) 
    response = client.users.create_user(body)
  rescue Atrium::ApiError => e
      Rails.logger.info "Exception when calling UsersApi->create_user: #{e}"
    end 

  def get_user_accounts
    accounts_response = client.accounts.list_user_accounts(current_user.guid)
    accounts_response.accounts
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling AccountsApi->list_user_accounts: #{e}"
  end 
  
  def member_status(member_guid,user_guid)
    api_key = Rails.application.credentials.dig(:mx_api_key)
    client_id = Rails.application.credentials.dig(:mx_client_id)
    client = Atrium::AtriumClient.new("#{api_key}", "#{client_id}")
    response = client.members.read_member_status(member_guid, user_guid)
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling MembersApi->read_member_status: #{e}"
  end
end 