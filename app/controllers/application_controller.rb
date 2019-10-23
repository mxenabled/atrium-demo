class ApplicationController < ActionController::Base
  def aggregate_member(member_guid)
    aggregation_response = client.members.aggregate_member(member_guid, current_user.guid)
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling MembersApi->aggregate_member: #{e}"
  end 

  def api_key
    @api_key ||= Rails.application.credentials.dig(:mx_api_key)
  end 

  def client 
    @client ||= Atrium::AtriumClient.new(api_key, client_id)
  end 

  def client_id
    @client_id ||= Rails.application.credentials.dig(:mx_client_id)
  end 

  def get_member_accounts(member_guid)
    accounts_response = client.members.list_member_accounts(member_guid, current_user.guid)
    accounts_response&.accounts
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling MembersApi->list_member_accounts: #{e}"
  end 

  def get_member_guid(member_id)
    member = Member.find(member_id) 
    member&.guid
  end 

  def read_institution(institution_code)
    institution_response = client.institutions.read_institution(institution_code)
    institution_response&.institution
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling InstitutionsApi->read_institution: #{e}"
  end

  def read_member_status(member_guid) 
    member_status_response = client.members.read_member_status(member_guid, current_user.guid)
    member_status_response&.member
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling MembersApi->read_member_status: #{e}"
  end 

  def credentials_to_array(credentials)
    credentials.map do |credential_guid, value| 
      { 
        "guid" => credential_guid, 
        "value"=> value
      }
    end 
  end 
end
