MettleMe::Application.routes.draw do

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  # Temporary root URL
  root :to => 'high_voltage/pages#show', :id => 'home'
  
  # Login/logout via SessionsController
  post  '/session'  => 'sessions#create'

  
  # Clearance users sign up
  resources :users, controller: 'users', only: [:create]  
  
  # Public 'Shop' page
  get '/shop' => 'products#recent', as: :recent_products
  
  # Public routes
  resources :stores, only: [:index]
  get '/stores/:slug' => 'stores#show', as: :store
  
  # Public products
  get '/stores/:store_slug/:slug-:id' => 'products#show', as: :product
  
  # Shopping cart
  get    '/cart'            => 'cart#show',     as: :cart
  put    '/cart/add/:id'    => 'cart#add',      as: :add_to_cart
  delete '/cart/remove/:id' => 'cart#remove',   as: :remove_from_cart
  get    '/cart/checkout'   => 'cart#checkout', as: :cart_checkout
  put    '/cart/update/:id'   => 'cart#update', as: :cart_update

  # Payments
  get '/payment/confirmed'  => 'payments#confirmed', as: :payment_confirmation
  
  # Contact form submissions
  post '/contact' => 'contact#create', as: :contact


  # Authenticated routes
  scope :module => 'authenticated' do
    # Users
    resource :user, :path_names => {:edit => "myprofile"},  only: [:edit, :update, :destroy] do
      get :sell, as: :register_seller
      get :change_password
      get :subregion_options
      get :help
      collection do
        get :year_money
        get :month_money
      end

      # Stores
      resource :store do
        get :subregion_options
        get :settings
        get :analytics
        get :store_items
      end
      # Products
      resources :products do

        collection do
          get :sub_categories_by_category
          get :stats
        end

      end
      
      # Messages
      resources :messages do
        get :trail_message
        post :reply
        collection do
          get :sent
          delete :destroy_multiple
        end
      end
      
      # Orders
      resources :orders, only: [:index]
      
      # Favourites
      post   '/favourites/:favoured_type' => 'favourites#create', as: :create_favourite_for
      delete '/favourites/:favoured_type/:favoured_id' => 'favourites#destroy', as: :destroy_favourite
      
      resources :favorites, :controller => "favourites", only: [:destroy] do
        collection do
          get :products, as: :products
          get :stores, as: :stores
        end
      end
    end     

  end  
  
  get 'auth/:provider/callback', to:  "sessions#create_from_omniauth"
  
end
