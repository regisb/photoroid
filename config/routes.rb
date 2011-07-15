RailsSandbox::Application.routes.draw do
  # Album 
  put 'albums/upload_images'
  match 'albums/download/:secret' => 'albums#download'
  match ":secret" => "albums#show", :secret => /([a-z]|[0-9]){32}/, :via => :get
  match "albums/:secret" => "albums#destroy", :secret => /([a-z]|[0-9]){32}/, :via => :delete
  resources :albums
  
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
  root :to => 'albums#index'
end
