RailsSandbox::Application.routes.draw do
  # Album 
  put 'album/upload_images'
  match 'album/download/:secret' => 'album#download'
  match ":secret" => "album#show", :secret => /([a-z]|[0-9]){32}/, :via => :get
  match "album/:secret" => "album#destroy", :secret => /([a-z]|[0-9]){32}/, :via => :delete
  resources :album
  
  # Images
  resources :image
  
  # User
  resources :user do
    collection do
      get 'logout'
      get 'login'
      post 'login'
    end
  end

  # Root
  root :to => 'album#index'
end
