Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root 'pages#dashboard'

  resources :notes, except: [:index, :show]

end
