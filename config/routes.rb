Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root 'pages#dashboard'

  resources :notes, except: [:index, :show]
  post 'notes/:id/like', to: 'notes#like', as: 'like'
  delete 'notes/:id/unlike', to: 'notes#unlike', as: 'unlike'

  post '/follow/:id', to: 'users#follow', as: 'follow'
  delete '/unfollow/:id', to: 'users#unfollow', as: 'unfollow'

end
