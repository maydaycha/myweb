Sun::Application.routes.draw do
  get '/email' => 'users#send_mail'
  # get "sessions/create"
  # get "sessions/destroy"
  get '/facebook/index' => 'third_party_login#index'
  get '/auth/facebook/callback' => 'third_party_login#facebook_create'
  get '/auth/google_oauth2/callback' => 'third_party_login#google_create'
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
  resources :project_public_messages

  # get  '/oauth' => "oauth#oauth_process"
  # get  '/get_access_token' => "oauth#get_access_token"
  # get  '/api' => "api#construct_access_token"
  # get  '/getUsersBySearch' => "api#getUsersBySearch"
  # get  '/getAccountDetails' => "api#getAccountDetails"

  # get  '/storeProjects' => "projects#storeProjects"
  # get  '/getProjectDetails' => "projects#getProjectDetails"

  get  '/oauth' => "oauth#oauth_process"
  get  '/get_access_token' => "oauth#get_access_token"
  # get    '/api' => "api#construct_access_token"
  # get    '/getUsersBySearch' => "api#getUsersBySearch"
  # get    '/getAccountDetails' => "api#getAccountDetails"

  get  '/getProjectDetails' => "projects#getProjectDetails"
  get  '/storeProjectsDetails' => "projects#storeProjectsDetails"
  get  '/getCategoryJobList' => "projects#getCategoryJobList"
  get  '/wirte_job_to_csv' => "projects#wirte_job_to_csv"
  get  '/excel_download' => "projects#excel_download"
  get  '/getPublicMessages/:project_id' => "projects#getPublicMessages"
  get  'project/update_budget' => "projects#update_budget"

  # project_public_messages
  get  '/public_message/edit_via_project/:project_id' => "project_public_messages#edit_via_project"
  post  '/public_message/update_via_project' => "project_public_messages#update_via_project"



  # angular
  get  '/api/translators' => "translators#index"

  post  '/api/translators/create' => "translators#create"
  # match "/api/translators/create" => "translators#create", via: :options

  get  '/api/translators/getJobCategory' => "translators#getJobCategory"

  get  '/api/translators/isLogin' => "translators#isLogin"
  post  '/api/translators/isLogin' => "translators#isLogin"
  # post  '/api/translators/isLogin' => "translators#isLogin"
  # match  '/api/translators/isLogin' => "translators#isLogin", via: :options

  post  '/api/translators/login' => "translators#login"
  # match  "/api/translators/login" => "translators#login", via: :options

  get  '/api/translators/logout' => "translators#logout"

  get  '/api/translators/csrf_token' => "translators#csrf_token"

  get  '/api/translators/get_project_by_translator' => "projects#get_project_by_translator"

  post 'project/update_project_from_angular' => "projects#update_project_from_angular"
  # match  'project/update_project_from_angular' => "projects#update_project_from_angular", via: :options


  get '/test' => "users#test"

  get '/set_word_count' => 'projects#set_word_count'
  get '/message/set_word_count' => 'project_public_messages#set_word_count'

  # freelancer api
  get  '/freelancer/searchProjects' => "freelancer#searchProjects"
  get  '/freelancer/getProjectDetails' => "freelancer#getProjectDetails"
  get  '/freelancer/storeProjectsDetails' => "freelancer#storeProjectsDetails"
  get  '/freelancer/getCategoryJobList' => "freelancer#getCategoryJobList"

  # users
  get '/users/login' => 'users#login'
end
