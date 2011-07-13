RailsSandbox::Application.routes.draw do
  resources :album
  resources :image
  resources :user do
    collection do
      get 'logout'
      get 'login'
    end
  end
  root :to => 'album#index'
  match ':controller(/:action(/:id(.:format)))'
  match 'show/:secret' => 'album#index'
end
