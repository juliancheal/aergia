Rails.application.routes.draw do
  root "static_pages#home"
  
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }, skip: [:sessions]
  
  devise_scope :user do
    get 'signin' => 'devise/sessions#new', :as => :new_user_session
    post 'signin' => 'devise/sessions#create', :as => :user_session
    delete 'signout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], as: :finish_signup, skip: [:sessions]
  
  resources :users, :only => [:edit, :show]
end
