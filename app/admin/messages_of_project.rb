ActiveAdmin.register MessagesOfProject do

  permit_params :id, :body, :user_id


  config.clear_action_items!

  # action_item :only => [:index] do
  #   link_to t("active_admin.new_model", model: :User), url: new_admin_user_path unless current_admin_user.is_service?
  # end

  # action_item only: :index do
  #   link_to 'Button text', new_admin_user_path
  # end

  index do
    id_column
  end





  controller do

    def new
      redirect_to admin_messages_of_projects_path
    end

    def create
    end

  end


end
