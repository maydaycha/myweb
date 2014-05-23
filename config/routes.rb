Sun::Application.routes.draw do

  captcha_route
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



  get "admins/index"
  get "admins/login"
  get "admins/authenticaiotn"


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
    resources :skills
    resources :skill_categorys
    namespace :profiles do
      post 'ajax_upload_img'
      post 'ajax_updae'
      post 'upload_img'
      post 'upload_portfolio_picture'
      get 'upload_portfolio_picture'
    end
  end

  #test
  post 'users/profiles/check_password' => 'users/profiles#check_password'
  get 'users/profiles/show_image/:id' => 'users/profiles#show_image'
  get 'import_from_csv' => 'skills#import_from_csv'
  get 'users/profiles/show_portfolio_image1/:index' => 'users/profiles#show_portfolio_image1'
  get 'users/profiles/show_portfolio_image2/:index' => 'users/profiles#show_portfolio_image2'

  get 'skills/exist' => 'skills#exist'
  get 'skills/autocomplete' => 'skills#autocomplete'


  namespace :index do
    get "sign_up"
  end

  root to: "index#index"
  get 'about' => 'index#about', :as => :index_about
  get 'rule' => 'index#rule', :as => :index_rule
  get 'contact' => 'index#contact', :as => :index_contact

  namespace :users do
    
    post 'add_to_favorite'
    delete 'remove_from_favorite'
    get 'check_email'
    get 'check_username'
  end

  scope :users do
    get 'search' => "users#search", :as => :users_search
    get 'search_category' => "users#search_category", :as => :user_search_category
    get 'detail/:id' => "users#detail", :as => :users_detail
  end

  devise_for :users, :controllers => {
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks",
    confirmations: "users/confirmations",
    passwords: "users/passwords"
  }

  devise_scope :user do
    get 'users/new2', to: 'users/registrations#new2', :as => :new2_user_registration
    get 'users/verify_email', to: 'users/registrations#verify_email', :as => :verify_user_registration
    get 'users/verify_success', to: 'users/registrations#verify_success', :as => :verify_user_registration_success
    get 'users/email_success', to: 'users/passwords#email_success', :as => :email_success
    get 'users/edit_error', to: 'users/passwords#edit_error', :as => :edit_passwords_error
  end

end
