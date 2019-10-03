module UsersHelper

  def read_institution(institution_code)
    api_key = Rails.application.credentials.dig(:mx_api_key)
    client_id = Rails.application.credentials.dig(:mx_client_id)
    client = Atrium::AtriumClient.new("#{api_key}", "#{client_id}")
    response = client.institutions.read_institution(institution_code)
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling InstitutionsApi->read_institution: #{e}"

  end 
end
