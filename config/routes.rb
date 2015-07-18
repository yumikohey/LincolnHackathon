Rails.application.routes.draw do

  root 'landing#index'

  get    'register'  => 'users#new'
  get    'login'     => 'sessions#new'
  post   'login'     => 'sessions#create'
#  delete 'logout'    => 'sessions#destroy'
  get 'logout'    => 'sessions#destroy'

  get '/auth/:provider/callback', to: 'users#amazon_login'

  get '/amazon', to: 'promotions#index'

  post '/upload_feed', to: 'users#upload_photofeed'

  get '/products/:asin', to: 'amznasins#show'

  resources :photofeeds, only: [:new, :create, :destroy]

  resources :users


  #post '/current_pain', to: 'option_chains#current_pain'


  # get '/weekly_pain', to: 'stocks#weekly_pain', as: 'weekly_pain'

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
