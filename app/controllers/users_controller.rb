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
      member_status = read_member_status(member.guid)
      institution = read_institution(member.institution_code)
      accounts = accounts_body(member.guid)
      { :member => {
        :member_guid => member.guid,
        :member_id => member.id,
        :institution_name => institution.name,
        :institution_logo => institution.small_logo_url,
        :connection_status => member_status.connection_status,
        :accounts => accounts
        }
      }
    end 
  end 
end 