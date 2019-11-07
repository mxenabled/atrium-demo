Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users/registrations"}

  resources :members do
    resources :registrations, :only => [:create], controller: 'members/registrations'
  end 

  resource :accounts, :only => [:show]
  resources :institutions, :only => [:index]
  resources :users, :only => [:show]
  
  root  'static_pages#home' 
  get  '/home',                  to: 'static_pages#home'
  get  '/registrations/new',     to: 'members/registrations#new'
  get  '/registrations/edit',    to: 'members/registrations#edit'
  
end