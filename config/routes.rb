Sun::Application.routes.draw do
  get "admins/index"
  get "admins/login"
  get "admins/authenticaiotn"
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


  # freelancer api
  namespace :freelancer do
    get 'searchProjects'
    get 'getProjectDetails'
    get 'storeProjectsDetails'
    get 'getCategoryJobList'
    get 'getAccountDetails'
    get 'getUsersBySearch'
  end

  namespace :odesks do
    get 'search_jobs'
  end

  namespace :projects do
    get 'wirte_job_to_csv'
    get 'excel_download'
    get 'update_budget'
    get 'set_word_count'
  end
  resources :projects


  namespace :translators do
    get 'login'
    get 'logout'
    post 'authentication'
    get 'projects'
    get 'edit_project'
    patch 'update_project_and_message'
  end
  resources :translators


  get 'oauth_start/:source' => 'oauth#oauth_start', :as => :oauth_start
  get 'get_access_token/:source' => 'oauth#get_access_token', :as => :get_access_token


  namespace :project_public_messages do
    get 'edit_via_project/:project_id' => 'project_public_messages#edit_via_project'
    get 'update_via_project'
  end

  get '/message/set_word_count' => 'project_public_messages#set_word_count'

  # test maydaycha
  # get '/email' => 'users#send_mail'
  # get '/facebook/index' => 'third_party_login#index'
  # get '/auth/google_oauth2/callback' => 'third_party_login#google_create'

  namespace :users do
    resources :profiles
  end



  # test scott
  root to: "users#index"

  devise_for :users, :controllers => { registrations: 'users/registrations', omniauth_callbacks: "users/omniauth_callbacks"}

  devise_scope :user do
    get 'new2', to: 'users/registrations#new2', :as => :new2_user_registration
  end

end
