RailsSandbox::Application.routes.draw do
  # Album 
  constraints(:secret => /([a-z]|[0-9]){32}/) do
    # This is stupid. Because I am not using ID but secret 
    # I have to redefine all my routes
    put 'albums/upload_images'
    match 'albums/download/:secret' => 'albums#download'
    match ":secret" => "albums#show", :via => :get
    match ":secret" => "albums#destroy", :via => :delete
    resources :albums
  end
  
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
