class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      redirect_to '/users/show'
    end 
  end
end
