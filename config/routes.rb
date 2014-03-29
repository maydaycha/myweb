Sun::Application.routes.draw do
  get "oauth/index"
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
  resources :projects
  resources :translators

  # get  '/oauth' => "oauth#oauth_process"
  # get  '/get_access_token' => "oauth#get_access_token"
  # get  '/api' => "api#construct_access_token"
  # get  '/getUsersBySearch' => "api#getUsersBySearch"
  # get  '/getAccountDetails' => "api#getAccountDetails"

  # get  '/searchProjects' => "projects#searchProjects"
  # get  '/storeProjects' => "projects#storeProjects"
  # get  '/getProjectDetails' => "projects#getProjectDetails"

  get  '/oauth' => "oauth#oauth_process"
  get  '/get_access_token' => "oauth#get_access_token"
  # get    '/api' => "api#construct_access_token"
  # get    '/getUsersBySearch' => "api#getUsersBySearch"
  # get    '/getAccountDetails' => "api#getAccountDetails"

  get  '/searchProjects' => "projects#searchProjects"
  get  '/getProjectDetails' => "projects#getProjectDetails"
  get  '/storeProjectsDetails' => "projects#storeProjectsDetails"
  get  '/getCategoryJobList' => "projects#getCategoryJobList"



  # angular front end
  get  '/angular' => "angular#index"

  post  '/angular/create' => "angular#create"
  match "/angular/create" => "angular#create", via: :options

  get  '/angular/getJobCategory' => "angular#getJobCategory"

  get  '/angular/isLogin' => "angular#isLogin"
  post  '/angular/isLogin' => "angular#isLogin"
  match  '/angular/isLogin' => "angular#isLogin", via: :options

  post  '/angular/login' => "angular#login"
  match  "/angular/login" => "angular#login", via: :options

  get  '/angular/logout' => "angular#logout"

  get  '/angular/csrf_token' => "angular#csrf_token"

  get  'angular/get_project_by_translator' => "projects#get_project_by_translator"

  post 'project/update_project_from_angular' => "projects#update_project_from_angular"
  match  'project/update_project_from_angular' => "projects#update_project_from_angular", via: :options

end
