class MembersController < ApplicationController
    def new 
        @code = params[:code]
        response = get_institution_creds(@code)
        @institution_credentials = response.credentials
        p @credentials
    end 

    def create
        member_credentials = params[:credentials].permit!().values
        response = create_atrium_member(params[:institution_code], member_credentials, params[:user_guid])
        p response
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

    def create_atrium_member(code, credential_hash, user_guid)
        member_info = {:member => {:institution_code => code, :credentials => credential_hash, :skip_aggregation => true}}
        #member_info = {:member => member_parameters}
        p member_info
        api_key = Rails.application.credentials.dig(:mx_api_key)
        client_id = Rails.application.credentials.dig(:mx_client_id)
        client = Atrium::AtriumClient.new("#{api_key}", "#{client_id}")
        body = Atrium::MemberCreateRequestBody.new(member_info) # MemberCreateRequestBody | Member object to be created with optional parameters (identifier and metadata) and required parameters (credentials and institution_code)
        p body
        begin
          #Create member
          response = client.members.create_member(user_guid, body)
          p response
        rescue Atrium::ApiError => e
          puts "Exception when calling MembersApi->create_member: #{e}"
        end
    end 
end
