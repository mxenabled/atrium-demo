class Members::RegistrationsController < ApplicationController
  def new
    challenge_questions = registration_params[:challenge_questions]
    @challenges = challenges_conversion(challenge_questions)
    @member_id = registration_params[:id]
    @member_guid = get_member_guid(@member_id)
  end 

  def create 
    challenges = credentials_to_array(registration_params[:challenges].to_h)
    resume_aggregation(registration_params[:member_guid], challenges)
    redirect_to '/users/show'
  end 

  def edit
    member_guid = get_member_guid(registration_params[:id])
    member_status = read_member_status(member_guid)
    handle_connection_status(member_status, member_guid, registration_params[:id])
  end 

private

  def bad_credentials_status(status, member_guid, member_id)
    aggregate_member(member_guid)
    poll_member_status(member_guid, member_id)
  end  

  def challenged_status(status, member_id, challenges)
    redirect_to registrations_new_path(:id => member_id, :challenge_questions => challenges)
  end 

  def challenges_conversion(challenge_questions) 
    challenge_questions.map do |challenge|
        eval(challenge)
    end
  end 
  
  def clean_status(status)
    redirect_to user_path(current_user.id)
  end 

  def display_message_status(member_id)
    redirect_to member_path(member_id)
  end   

  def handle_connection_status(member_status, member_guid, member_id)
    connection_status = member_status.connection_status
    case connection_status
    when "CONNECTED", "RESUMED", "CREATED"
      clean_status(connection_status)
    when "CHALLENGED"
      challenged_status(connection_status, member_id, member_status.challenges)
    when "EXPIRED", "RECONNECTED"
      bad_credentials_status(connection_status, member_guid, member_id)
    else 
      display_message_status(member_id)
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
      sleep(1)
      member_status = read_member_status(member_guid)
      break unless member_status.connection_status == "CREATED" || member_status.connection_status == "RESUMED"
    end 
    handle_connection_status(member_status, member_guid, member_id)
  end   

  def registration_params
    params.permit(:member_guid, :id, :authenticity_token, :commit, :challenge_questions => [], :challenges => {})
  end 

  def resume_aggregation(member_guid, challenges)
    member_info = {:member => {:challenges => challenges}}
    body = Atrium::MemberResumeRequestBody.new(member_info)
    resume_aggregation_response = client.members.resume_member(member_guid, current_user.guid, body)
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling MembersApi->resume_member: #{e}"
  end 
end 
