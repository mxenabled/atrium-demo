class Members::RegistrationsController < ApplicationController
  def new
      @challenges = challenges_hash
      @member_guid = registration_params[:member_guid]
  end 

  def create 
      challenges = challenges_to_array(challenges_hash)
      mfa_resume_agg(params[:member_guid], challenges)
  end 

private
  def aggregate_member(member_guid)
    aggregation_response = client.members.aggregate_member(member_guid, current_user.guid)
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling MembersApi->aggregate_member: #{e}"
    end 

  def mfa_resume_agg(member_guid, challenges)
    member_info = {:member => {:challenges => challenges}}
    body = Atrium::MemberResumeRequestBody.new(member_info)
    resume_aggregation_response = client.members.resume_member(member_guid, current_user.guid, body)
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling MembersApi->resume_member: #{e}"
  end 

  def registration_params
    params.permit(:member_guid)
  end 

  def challenges_hash
    params.require(:challenges).permit!.to_h
  end 

  def challenges_to_array(challenges)
    challenges_array = []
    challenges.map do |challenge_guid, value| 
      challenges_array.push({ 
        "guid" => challenge_guid, 
        "value"=> value
      })
    end 
    challenges_array
  end 
end
