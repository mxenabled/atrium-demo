module Members::RegistrationsHelper
  def mfa_challenge_type(challenge)
    case challenge.type
    when "IMAGE_DATA"
     image_tag "#{challenge.image_data}"
    when "OPTIONS"
      #load options partial
    else 
      return
    end 
  end 
end
