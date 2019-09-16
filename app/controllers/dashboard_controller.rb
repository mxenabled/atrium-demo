class DashboardController < ApplicationController
    def index   
    end 

    private 
      def get_institutions
        api_key = Rails.application.credentials.dig(:mx_api_key)
        client_id = Rails.application.credentials.dig(:mx_client_id)
        client = Atrium::AtriumClient.new(api_key, client_id)
        begin
          #List institutions
          response = client.institutions.list_institutions(opts)
          p response
        rescue Atrium::ApiError => e
          puts "Exception when calling InstitutionsApi->list_institutions: #{e}"
        end
      end 
end
