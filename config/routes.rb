FirstPass::Application.routes.draw do

  root to: "static_pages#home"
  
  resources :users, except: [:new, :destroy, :index] do
    resources :hosted_files, only: :show
    resources :works, except: :destroy
    resources :statements, only: [:index, :create]
    resources :audio_products, only: :create
  end

  namespace :admin do
    get :users_pending, controller: :users_pending, action: :index  # This is verbose in order to have admin_users_pending over admin_users_pending_index
    put :users_pending, controller: :users_pending, action: :update
    get :works_pending, controller: :works_pending, action: :index
    put :works_pending, controller: :works_pending, action: :update
    resources :works, only: [:show]
    get 'allstatements', to: "statements#indexall"
    resources :statements
    resources :users, only: [:index] do
      get 'search', on: :collection
      resources :works, only: [:index]
      resources :statements, only: :index
    end
  end 

  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets

  match '/signout', to: 'sessions#destroy', via: :delete
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
