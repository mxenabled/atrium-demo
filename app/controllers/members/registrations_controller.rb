class Members::RegistrationsController < ApplicationController
  def new
      @challenges = challenges_hash
      @member_guid = registration_params[:member_guid]
  end 

  def create 
      challenges = credentials_to_array(challenges_hash)
      resume_aggregation(registration_params[:member_guid], challenges)
  end 

private
  def challenges_hash
    params.require(:challenges).permit!.to_h
  end 

  def resume_aggregation(member_guid, challenges)
    member_info = {:member => {:challenges => challenges}}
    body = Atrium::MemberResumeRequestBody.new(member_info)
    resume_aggregation_response = client.members.resume_member(member_guid, current_user.guid, body)
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling MembersApi->resume_member: #{e}"
  end 

  def registration_params
    params.permit(:member_guid)
  end 
end
