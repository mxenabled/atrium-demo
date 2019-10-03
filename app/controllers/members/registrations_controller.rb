class Members::RegistrationsController < ApplicationController
  def new
      @challenges = params[:challenges]
      @member_guid = params[:member_guid]
  end 

  def create 
      challenges = resume_agg_params(params[:challenges_arr])
      mfa_resume_agg(params[:member_guid], challenges)
  end 

  def show
  end 

private

  def aggregate_member(member_guid)
    response = client.members.aggregate_member(member_guid, current_user.guid)
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling MembersApi->aggregate_member: #{e}"
    end 

  def mfa_resume_agg(member_guid, challenges_arr)
    member_info = {:member => {:challenges => challenges_arr}}
    body = Atrium::MemberResumeRequestBody.new{member_info})
    response = client.members.resume_member(member_guid, current_user.guid, body)
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling MembersApi->resume_member: #{e}"
  end 

  def challenges_to_array(challenges)
    challenges_array = []
    challenges.each do |challenge_guid, value| 
      challenges_array.push({ 
        "guid" => challenge_guid, 
        "value"=> value
      })
    end 
    challenges_array
  end 
end
