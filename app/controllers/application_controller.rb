class ApplicationController < ActionController::Base
  def api_key
    @api_key ||= Rails.application.credentials.dig(:mx_api_key)
  end 

  def client 
    @client ||= Atrium::AtriumClient.new(api_key, client_id)
  end 

  def client_id
    @client_id ||= Rails.application.credentials.dig(:mx_client_id)
  end 
end
