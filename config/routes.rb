RailsSandbox::Application.routes.draw do
  put 'album/upload_images'
  match 'album/download/:secret' => 'album#download'
  #match "album/:secret" => "album#show"
  match "album/show/:secret" => "album#show"
  resources :album

  resources :image
  resources :user do
    collection do
      get 'logout'
      get 'login'
      post 'login'
    end
  end
  root :to => 'album#index'
  #match ':controller(/:action(/:id(.:format)))'
  match 'show/:secret' => 'album#index'
end
