class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @members ||= members_body(current_user.members.all)
  end 

private 
  def accounts_body(member_guid)
    accounts = get_member_accounts(member_guid)
    accounts.map do |account|
      {
        :guid => account.guid,
        :name => account.name,
        :balance => account.balance
      }
    end 
  end 

  def members_body(members)
    members.map do |member|
      institution = read_institution(member.institution_code)
      accounts = accounts_body(member.guid)
      { :member => {
        :member_guid => member.guid,
        :institution_name => institution.name,
        :institution_logo => institution.small_logo_url,
        :accounts => accounts
        }
      }
    end 
  end 
end 