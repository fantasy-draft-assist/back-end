Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  ### REGISTRATION/LOGIN ROUTES

  post "registration", to: "registrations#create"
  post "login", to: "registrations#login"
  delete "registration", to: "registrations#destroy"

  ### OAUTH ROUTES

  get 'oauth/:user_id', to: 'oauth#new', as: 'oauth' # oauth_url oauth_path
  get 'oauth/:user_id/authorize', to: 'oauth#create', as: 'authorize'

  ### METHODS TO FROND END
  # one player data
  get 'players/:yahoo_player_id/:season', to: 'players#one', as: 'player'
  # all players data 
  get 'players/index', to: 'players#index'
  get 'players/index/:season', to: 'players#season'

  resources :leagues

  resources :teams do
    resources :fantasy_players
  end


  ### STRAIGHT TO BROWSER ROUTES

  get 'yahoo/:user_id/stats/:game_key/:player_key', to: 'players#bplayerpage'
  get 'yahoo/:user_id/league/:game_key/:league_key', to: 'players#bleague'
  get 'yahoo/:user_id/team/:game_key/:league_key/:team_key', to: 'players#bteam'
  get 'yahoo/:user_id/transactions/:game_key/:league_key', to: 'players#btransactions'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
