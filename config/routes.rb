Rails.application.routes.draw do
  devise_for :users 

  as :user do
    get 'user', :to => 'users#create', :as => :user_root
  end

  resources :members, :only => [:new, :create, :edit, :show, :update] do
    resources :registrations, :only => [:new, :create, :show], controller: 'members/registrations'
  end 

  resources :accounts, :only => [:show]
  resources :institutions, :only => [:index]
  resources :users, :only => [:show, :create]
  
  root  'static_pages#home' 
  get  '/home',                  to: 'static_pages#home'
  get  '/registrations/new',     to: 'members/registrations#new'
  get  '/registrations/show',    to: 'members/registrations#show'
end