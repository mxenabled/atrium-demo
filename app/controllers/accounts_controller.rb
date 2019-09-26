class AccountsController < ApplicationController
  def show
    account_response = read_account
    transaction_response = list_transactions
    @transactions = transaction_response.transactions
    @account = account_response.account
  end

  private 
 
  def read_account 
    account_guid = params[:account_guid]
    user_guid = current_user.guid
    api_key = Rails.application.credentials.dig(:mx_api_key)
    client_id = Rails.application.credentials.dig(:mx_client_id)
    client = Atrium::AtriumClient.new("#{api_key}", "#{client_id}")
    begin
      #Read an account
      response = client.accounts.read_account(account_guid, user_guid)
      p response
    rescue Atrium::ApiError => e
      Rails.logger.info "Exception when calling AccountsApi->read_account: #{e}"
    end
  end 

  def list_transactions
    account_guid = params[:account_guid]
    user_guid = current_user.guid
    api_key = Rails.application.credentials.dig(:mx_api_key)
    client_id = Rails.application.credentials.dig(:mx_client_id)
    client = Atrium::AtriumClient.new("#{api_key}", "#{client_id}")
    begin
      #List account transactions
      response = client.accounts.list_account_transactions(account_guid, user_guid)
      p response
    rescue Atrium::ApiError => e
      Rails.logger.info "Exception when calling AccountsApi->list_account_transactions: #{e}"
    end
  end 

  def account_params
    params.require(:account_guid, :institution_code)
  end 
end
