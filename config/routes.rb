Rails.application.routes.draw do
  
  resources :members
  devise_for :users 

  as :user do
    get 'users', :to => 'users#atrium_create', :as => :user_root
  end

  root  'static_pages#home' 
  get   '/home',             to: 'static_pages#home'
  get   '/help',             to: 'static_pages#help'
  get   '/user_profile',     to: 'users#profile'
  get   '/institutions',     to: 'institutions#list'
  get   '/user_stuff',       to: 'users#atrium_create'
  get   '/add_member',       to: 'members#new'
  post  '/atrium_member',    to: 'members#create'
  get   '/view_member',      to: 'members#show'    
end
