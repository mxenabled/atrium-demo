module Members::RegistrationsHelper
  def mfa_image(challenge)
    if challenge.type == "IMAGE_DATA"
      image_tag "#{challenge.image_data}"
    end
  end

  def mfa_type(challenge, f)
    if challenge.type == "TEXT" || challenge.type == "IMAGE_DATA"
      render partial: "input_mfa", locals: { f: f, challenge: challenge }
    end 
  end 
end