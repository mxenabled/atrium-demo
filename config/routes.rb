Rails.application.routes.draw do

  devise_for :users, :controllers => {:registrations => "users/registrations"}

  resources :members
  resource :registrations, :only => [:create, :edit, :new]
  resource :accounts, :only => [:show]
  resources :institutions, :only => [:index]

  root  'static_pages#home' 
end