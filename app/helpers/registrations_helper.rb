module RegistrationsHelper
  def mfa_image(challenge)
    image_tag "#{challenge.image_data}" if challenge.type == "IMAGE_DATA" 
  end

  def mfa_type(challenge, f)
    if challenge.type == "TEXT" || challenge.type == "IMAGE_DATA"
      render partial: "input_mfa", locals: { f: f, challenge: challenge }
    end 
  end 
end