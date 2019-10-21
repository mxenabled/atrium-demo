module UsersHelper
  def member_message(connection_status)
    unless connection_status == "CONNECTED"
      if connection_status == "RESUMED" || connection_status == "CREATED"
        "Please wait while we finish importing all of your membership data!"
      else 
        "Whoops! It looks like there were some issues when trying to import your membership!"
      end 
    end 
  end
  
  def member_has_issues(connection_status)
    if connection_status == "CONNECTED" || connection_status == "RESUMED" || connection_status == "CREATED" 
      false 
    else
      true 
    end 
  end 
end
