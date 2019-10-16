module MembersHelper
  def status_messages(connection_status)
    case connection_status
    when "CHALLENGED"
      "Your account requires further verification! To authenticate your membership please go to 'resolve issues' and answer the challenges!"
    when "CLOSED"
      "Your membership has been marked as closed! If it becomes re-opened you may import the membership"
    when "DEGRADED"
     "Your account has attempted to be imported too many times! Please try again later!"
    when "DELAYED"
      "Importing your membership has taken longer than expected! Please check back later!" 
    when "DENIED"
      "The credentials entered do not match your credentials at this institution. Please re-enter your credentials to continue importing data."
    when "DISCONTINUED"
      "Connections to this institution are no longer supported! Currently you will be unable to import this membership!"
    when "FAILED"
      "There was a problem validating your credentials with your institution. Please try again later!"
    when "IMPEDED"
      "Your attention is needed at this institutions website! Please log in to the appropriate website for this institution and follow the steps to resolve this issue" 
    when "LOCKED"
      "Your account is currently locked! Please log onto your financial institutions website and follow the steps to resolve the issue." 
    when "PREVENTED"
      "The last 3 attempts to access your memebership have failed! Please re-enter your credentials to continue importing your data"
    end 
  end 
end
