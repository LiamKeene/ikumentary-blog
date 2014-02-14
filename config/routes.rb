Ikumentary::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  namespace :admin do
    get '', to: 'dashboard#index', as: '/'

    resources :users
    resources :articles
    resources :comments
    resources :categories
    resources :tags

    resources :sessions, only: [:create]

    get 'signin', to: 'sessions#new', as: 'sign_in'
    delete 'signout', to: 'sessions#destroy', as: 'sign_out'
  end

  resources :categories, only: [:index, :show] do
    get ':id/page/:page', :to => 'categories#show', on: :collection
  end

  resources :tags, only: [:index, :show] do
    get ':id/page/:page', :to => 'tags#show', on: :collection
  end

  resources :articles, only: [:index, :show], path: '/' do
    get 'feed.:format', to: 'articles#feed', format: 'atom', on: :collection
    get 'page/:page', to: 'articles#index', on: :collection
    resources :comments, only: [:create]
  end

  get 'pages/:id', to: 'articles#show_page', as: 'article_page'

  root 'articles#index'

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