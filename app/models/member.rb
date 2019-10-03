class Member < ApplicationRecord
  belongs_to :user

  def self.from_atrium_member(atrium_member, user_id)
    Member.new(
      :guid => atrium_member.guid, 
      :user_guid => atrium_member.user_guid, 
      :institution_code => atrium_member.institution_code, 
      :user_id => user_id
      )
  end
end
