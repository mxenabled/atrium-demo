class Members::RegistrationsController < ApplicationController
  def new
    challenge_questions = registration_params[:challenge_questions]
    @challenges = challenges_conversion(challenge_questions)
    @member_id = registration_params[:member_id]
    @member_guid = get_member_guid(@member_id)
  end 

  def create 
    challenges = credentials_to_array(registration_params[:challenges].to_h)
    resume_aggregation(registration_params[:member_guid], challenges)
    redirect_to '/users/show'
  end 

  def show
    member_guid = get_member_guid(registration_params[:member_id])
    member_status = read_member_status(member_guid)
    handle_connection_status(member_status, member_guid, registration_params[:member_id])
  end 

private
  def challenges_conversion(challenge_questions) 
    challenge_questions.map do |challenge|
        eval(challenge)
    end
  end 
  
  def handle_connection_status(member_status, member_guid, member_id)
    member_status.connection_status
    case member_status.connection_status
    when "CONNECTED", "RESUMED", "CREATED"
      redirect_to user_path(current_user.id)
    when "CHALLENGED"
      redirect_to new_member_registration_path(:member_id => member_id, :challenge_questions => member_status.challenges)
    when "EXPIRED", "RECONNECTED"
      aggregate_member(member_guid)
      poll_member_status(member_guid, member_id)
    when "IMPORTED", "DENIED", "PREVENTED", "FAILED"
      redirect_to edit_member_path(:id => member_id)
    else 
      redirect_to member_path(member_id)
    end
  end 

  def list_challenges(member_guid)
    challenges_response = client.members.list_member_mfa_challenges(member_guid, current_user.guid)
    challenges_response&.challenges
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling MembersApi->list_member_mfa_challenges: #{e}"
  end 

  def poll_member_status(member_guid, member_id)
    member_status = read_member_status(member_guid)
    loop do 
      sleep(3)
      member_status = read_member_status(member_guid)
      break unless member_status.connection_status == "CREATED" || member_status.connection_status == "RESUMED"
    end 
    handle_connection_status(member_status, member_guid, member_id)
  end   

  def registration_params
    params.permit(:member_guid, :member_id, :authenticity_token, :commit, :challenge_questions => [], :challenges => {})
  end 

  def resume_aggregation(member_guid, challenges)
    member_info = {:member => {:challenges => challenges}}
    body = Atrium::MemberResumeRequestBody.new(member_info)
    resume_aggregation_response = client.members.resume_member(member_guid, current_user.guid, body)
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling MembersApi->resume_member: #{e}"
  end 
end