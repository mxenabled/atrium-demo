Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users/registrations"}

  as :user do
    get 'user', :to => 'users#show', :as => :user_root
  end

  resources :members, :only => [:new, :create, :show] do
    resources :registrations, :only => [:create], controller: 'members/registrations'
  end 

  resources :accounts, :only => [:show]
  resources :institutions, :only => [:index]
  resources :users, :only => [:show]
  
  root  'static_pages#home' 
  get  '/home',                  to: 'static_pages#home'
  get  '/registrations/new',     to: 'members/registrations#new'
  get  '/registrations/edit',    to: 'members/registrations#edit'

end