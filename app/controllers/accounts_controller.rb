class AccountsController < ApplicationController
  def show
    p @account = read_account
    @transactions = list_transactions
  end

private 
 
  def account_guid
    account_params = params.permit(:account_guid)
    account_params[:account_guid]
  end

  def list_transactions
    transaction_response = client.accounts.list_account_transactions(account_guid, current_user.guid)
    transaction_response&.transactions
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling AccountsApi->list_account_transactions: #{e}"
  end 

  def read_account 
    account_response = client.accounts.read_account(account_guid, current_user.guid)
    account_response&.account
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling AccountsApi->read_account: #{e}"
  end 
end
