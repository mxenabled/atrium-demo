class MembersController < ApplicationController
    def new 
        @code = params[:code]
        response = get_institution_creds(@code)
        @credentials = response.credentials
    end 

    private 

    def get_institution_creds(code)

        api_key = Rails.application.credentials.dig(:mx_api_key)
        client_id = Rails.application.credentials.dig(:mx_client_id)
        client = Atrium::AtriumClient.new("#{api_key}", "#{client_id}")
        institution_code = code
        
        begin
          #Read institution credentials
          response = client.institutions.read_institution_credentials(institution_code)
          p response
        rescue Atrium::ApiError => e
          puts "Exception when calling InstitutionsApi->read_institution_credentials: #{e}"
        end
    end

end
