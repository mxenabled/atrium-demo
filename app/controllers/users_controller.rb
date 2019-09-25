class UsersController < ApplicationController
  before_action :authenticate_user!

    def atrium_create
        @response = create_atrium_user
        @atrium_user_guid = @response.user.guid
        current_user.update_attribute(:guid, @atrium_user_guid)
        redirect_to :action => "list", :controller => "institutions"
    end 

    def profile
      response = get_user_accounts
      @accounts = response.accounts
      @user_guid = current_user.guid
      @members = current_user.members.all.to_a
    end 

  private 

  def create_atrium_user
    userInfo = {:user => {:identifier => SecureRandom.uuid}}
    api_key = Rails.application.credentials.dig(:mx_api_key)
    client_id = Rails.application.credentials.dig(:mx_client_id)
    client = Atrium::AtriumClient.new("#{api_key}", "#{client_id}")
    body = Atrium::UserCreateRequestBody.new(userInfo) # UserCreateRequestBody | User object to be created with optional parameters (identifier, is_disabled, metadata)
    begin
        #Create user
        response = client.users.create_user(body)
        p response
      rescue Atrium::ApiError => e
        puts "Exception when calling UsersApi->create_user: #{e}"
      end
    end 

  def get_user_accounts
    api_key = Rails.application.credentials.dig(:mx_api_key)
    client_id = Rails.application.credentials.dig(:mx_client_id)
    client = Atrium::AtriumClient.new("#{api_key}", "#{client_id}")
    user_guid = current_user.guid

    begin
      #List accounts for a user
      response = client.accounts.list_user_accounts(user_guid)
      p response
    rescue Atrium::ApiError => e
      puts "Exception when calling AccountsApi->list_user_accounts: #{e}"
    end
  end 
  
  def poll_member_status(member_guid,user_guid)
    api_key = Rails.application.credentials.dig(:mx_api_key)
    client_id = Rails.application.credentials.dig(:mx_client_id)
    client = Atrium::AtriumClient.new("#{api_key}", "#{client_id}")
    begin
      #Read member connection status
      response = client.members.read_member_status(member_guid, user_guid)
      p response
    rescue Atrium::ApiError => e
      puts "Exception when calling MembersApi->read_member_status: #{e}"
    end
  end
end 