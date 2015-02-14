Sun::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
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
    post 'add_to_favorite'
    delete 'remove_from_favorite'
    post 'messages_of_project'
  end
  scope :projects do
    get 'search' => "projects#search", :as => :projects_search
    get 'apply/:id' => "projects#apply_new", :as => :projects_apply_new
    post 'apply' => "projects#apply_create", :as => :projects_apply_create
    get 'detail/:id' => "projects#detail", :as => :projects_detail
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

  resources :project_questions

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
    namespace :employer do
      namespace :company do
        resources :profiles
        namespace :profiles do
          post 'ajax_updae'
          post 'ajax_upload_img'
        end
      end
      namespace :personal do
        resources :profiles
        namespace :profiles do
          post 'ajax_updae'
          post 'ajax_upload_img'
        end
      end
    end
  end

  post 'users/profiles/check_password' => 'users/profiles#check_password'
  post 'users/profiles/get_sub_category' => 'users/profiles#get_sub_category'
  get 'users/profiles/show_image/:id' => 'users/profiles#show_image'
  get 'users/profiles/show_portfolio_image/:index' => 'users/profiles#show_portfolio_image'
  get 'users/profiles/download_document/:index' => 'users/profiles#download_portfolio_document', as: "users_download_document"

  get 'users/employer/company/show_image/:id' => 'users/employer/company/profiles#show_image'
  get 'users/employer/personal/show_image/:id' => 'users/employer/personal/profiles#show_image'

  get 'import_from_csv' => 'skills#import_from_csv'

  get 'skills/exist' => 'skills#exist'
  get 'skills/autocomplete' => 'skills#autocomplete'

  #get 'project_find/find' => 'project_find#freelencer_find'



  namespace :index do
    get "sign_up"
  end

  root to: "index#index"
  get 'about' => 'index#about', :as => :index_about
  get 'rule' => 'index#rule', :as => :index_rule
  get 'contact' => 'index#contact', :as => :index_contact
  get 'project_category' => 'index#project_category', :as => :index_project_category
  get 'user_category' => 'index#user_category', :as => :index_user_category
  get 'byot' => 'index#byot', :as => :index_byot
  get 'group' => 'index#group', :as => :index_group
  get 'groupIns' => 'index#groupIns', :as => :index_groupIns
  get 'howitwork' => 'index#howitwork', :as => :index_howitwork
  get 'howitworkP2' => 'index#howitworkP2', :as => :index_howitworkP2
  get 'howitworkP3_f' => 'index#howitworkP3_f', :as => :index_howitworkP3_f
  get 'howitworkP3_other' => 'index#howitworkP3_other', :as => :index_howitworkP3_other
  get 'howitworkP3' => 'index#howitworkP3', :as => :index_howitworkP3
  get 'howitworkP5' => 'index#howitworkP5', :as => :index_howitworkP5
  get 'howitworkP5_j' => 'index#howitworkP5_j', :as => :index_howitworkP5_j
  get 'howitworkP5_other' => 'index#howitworkP5_other', :as => :index_howitworkP5_other
  get 'partners' => 'index#partners', :as => :index_partners
  get 'solutions' => 'index#solutions', :as => :index_solutions
  get 'SandBYOT' => 'index#SandBYOT', :as => :index_SandBYOT   
  get 'tool_page' => 'index#tool_page', :as => :index_tool_page

  namespace :users do
    post 'add_to_favorite'
    get 'check_email'
    get 'check_username'
    delete 'remove_from_favorite'
  end

  scope :users do
    get 'search' => "users#search", :as => :users_search
    get 'search_category' => "users#search_category", :as => :user_search_category
    get 'detail/:id' => "users#detail", :as => :users_detail
    get 'find/:id' => "users#freelencer_find", :as => :users_find
    get 'my_job/:id' => "users#freelencer_job", :as => :my_job
    # get 'my_job/:id' => "users#freelencer_job", :as => :my_job
  end

  devise_for :users, :controllers => {
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks",
    confirmations: "users/confirmations",
    passwords: "users/passwords"
  }

  devise_scope :user do
    get 'users/new2', to: 'users/registrations#new2', :as => :new2_user_registration
    get 'users/employer_new', to: 'users/registrations#employer_new', :as => :new_employer_user_registration
    get 'users/employer_new_social', to: 'users/registrations#employer_new_social', :as => :new_employer_social_user_registration
    get 'users/verify_email', to: 'users/registrations#verify_email', :as => :verify_user_registration
    get 'users/verify_success', to: 'users/registrations#verify_success', :as => :verify_user_registration_success
    get 'users/email_success', to: 'users/passwords#email_success', :as => :email_success
    get 'users/edit_error', to: 'users/passwords#edit_error', :as => :edit_passwords_error
  end

  resources :users


  get 'application/show_image' => 'application#show_image'

 

  namespace :meet_rooms do
    get 'booking'
    get 'byot'
    get 'enterprise'
    get 'waiting_meet'
    get 'get_waiting_case'
    get 'get_waiting_interview'
    get 'upcoming_meet'
    get 'get_upcoming'
    get 'finished_meet'
    get 'get_finished'
    get 'get_all_meet'
    get 'contact_person'
    get 'buy'
    get 'update_members'
  end

  scope :meet_rooms do
    get 'cancel/:id' => 'meet_rooms#cancel', :as => :meet_rooms_cancel
    get 'detail/:id' => 'meet_rooms#detail', :as => :meet_rooms_detail
  end

  namespace :meet_room_members do
    get 'get_contact_person'
  end

  resources :meet_rooms do
    resources :meet_room_members
  end

end
