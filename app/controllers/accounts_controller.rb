class AccountsController < ApplicationController
  def show
    @account = read_account
    @transactions = list_transactions
  end

private 
 
  def account_params
<<<<<<< HEAD
    params.permit(:account_guid, :method, :id)
=======
    params.permit(:account_guid)
>>>>>>> 951fa91a987dc1c4e947c2f8994bee2105bb4619
  end

  def list_transactions
    transaction_response = client.accounts.list_account_transactions(account_params[:account_guid], current_user.guid)
    transaction_response&.transactions
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling AccountsApi->list_account_transactions: #{e}"
  end 

  def read_account 
    account_response = client.accounts.read_account(account_params[:account_guid], current_user.guid)
    account_response&.account
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling AccountsApi->read_account: #{e}"
  end 
end
