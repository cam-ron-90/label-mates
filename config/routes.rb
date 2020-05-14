Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :pages do
    collection do
      get :authenticate
      get :callback
      get :artist_search
      get :label_search
    end
  end
end
