Rails.application.routes.draw do
  devise_for :users 

  as :user do
    get 'user', :to => 'users#create', :as => :user_root
  end

  resources :accounts, :only => [:show]
  resources :institutions, :only => [:index]
  resources :members, :only => [:new, :create, :show]
  resources :users, :only => [:create, :show]

  root  'static_pages#home' 
  get   '/home',             to: 'static_pages#home'
end