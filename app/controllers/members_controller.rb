class MembersController < ApplicationController
  before_action :authenticate_user!

    def new 
        @code = params[:code]
        response = get_institution_creds(@code)
        @institution_credentials = response.credentials
    end 

    def create
        @member = Member.new
        credentials = credential_params(params[:credentials])
        # credentials = credential_params(params[:credentials])
        # member_credentials = params[:credentials].values
        # institution_credentials = params[:credentials].keys
        # credentials = institution_credentials.zip(member_credentials)
        # credentials.map! { |n| [n].to_h }
        response = create_atrium_member(params[:institution_code], credentials, params[:user_guid])
        @member.guid = response.member.guid
        @member.user_guid = response.member.user_guid
        @member.institution_code = response.member.institution_code
        @member.user_id = current_user.id
        if @member.save!
            redirect_to '/user_profile'
        else  
            redirect_to '/institutions'
        end         
    end 

    def show 
      @member_guid = member_params
      poll_member_status(@member_guid, current_user.guid)
    end 

    private 

    def create_atrium_member(code, creds, user_guid)
      member_info = {:member => {:institution_code => code, :credentials => creds, :skip_aggregation => false}}
      api_key = Rails.application.credentials.dig(:mx_api_key)
      client_id = Rails.application.credentials.dig(:mx_client_id)
      client = Atrium::AtriumClient.new("#{api_key}", "#{client_id}")
      body = Atrium::MemberCreateRequestBody.new(member_info)
      p body 
      begin
        #Create member
        response = client.members.create_member(user_guid, body)
        p response
      rescue Atrium::ApiError => e
        puts "Exception when calling MembersApi->create_member: #{e}"
      end
  end 

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

    def member_params
      params.require(:member_guid)
    end 

    def poll_member_status(member_guid,user_guid)
      api_key = Rails.application.credentials.dig(:mx_api_key)
      client_id = Rails.application.credentials.dig(:mx_client_id)
      client = Atrium::AtriumClient.new("#{api_key}", "#{client_id}")
      begin
        #Read member connection status
        response = client.members.read_member_status(member_guid, user_guid)
        p response
      rescue Atrium::ApiError => e
        puts "Exception when calling MembersApi->read_member_status: #{e}"
      end
    end 

  def credential_params(creds)
    member_credentials = creds.values
    institution_credentials = creds.keys
    credentials = institution_credentials.zip(member_credentials)
    newCred = []
    for credential in credentials do 
      newCred.push({:guid => credential[0], :value => credential[1]})
    end 
    credentials = newCred
  end 
end