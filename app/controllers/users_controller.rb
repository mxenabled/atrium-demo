class UsersController < ApplicationController
  before_action :authenticate_user!

  def create
    @atrium_user = create_atrium_user
    current_user.update_attribute(:guid, @atrium_user.guid)
    redirect_to :action => "index", :controller => "institutions"
  end 

  def show
    @members = current_user.members.all
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
    atrium_user = client.users.create_user(body)
    atrium_user&.user
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling UsersApi->create_user: #{e}"
    end 
end 