require 'sidekiq/web'

Rails.application.routes.draw do

  post 'monitor/status' => "services#job_status",
    defaults: { format: :json }, constraints: { format: :json }

  devise_for :users
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/monitor', as: :sidekiq
  end

  root to: "high_voltage/pages#show", id: "home"

  resources :imports, only: [:index, :create]
  # resources :logs, only: :index

  get "reports/logs" => "reports#logs"
  get "reports/comparison" => "reports#comparison"

  # get  "/logs"    => "logs#index",   as: :logs
  # get  "/compare" => "logs#compare", as: :compare
  # get  "/imports" => "imports#index",  as: :imports
  # post "/imports" => 'imports#create', as: :new_import
  # root to: "logs#index", as: :logs

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

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
