class UsersController < ApplicationController
    def atrium_create
        @response = get_atrium_user
        @atrium_user_guid = @response.user.guid
        current_user.update_attribute(:guid, @atrium_user_guid)
        redirect_to :action => "list", :controller => "institutions"
    end 

    def profile
    end 

private 
def get_atrium_user
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
end 