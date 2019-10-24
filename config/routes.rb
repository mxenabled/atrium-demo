Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users/registrations"}

  as :user do
    get 'user', :to => 'users#show', :as => :user_root
  end
<<<<<<< HEAD

  resources :members, :only => [:new, :create, :edit, :show, :update] do
    resources :registrations, :only => [:new, :create, :show], controller: 'members/registrations'
  end 

  resources :accounts, :only => [:show]
  resources :institutions, :only => [:index]
  resources :users, :only => [:show]
  
=======
  resources :accounts, :only => [:show]
  resources :institutions, :only => [:index]
  resources :members, :only => [:new, :create, :show]
  resources :users, :only => [:show]


>>>>>>> 127d636b937b02bf7cd1e8f16de7ec2ea99b6a8b
  root  'static_pages#home' 
  get  '/home',                  to: 'static_pages#home'
  get  '/registrations/new',     to: 'members/registrations#new'
  get  '/registrations/show',    to: 'members/registrations#show'
end