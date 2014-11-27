ActiveAdmin.register AdminUser do

  permit_params :email, :password, :password_confirmation, :username, :first_name, :last_name, :is_service, :is_translator, :authority_group_id

  # hide resource from menu
  # menu :if => proc { not current_admin_user.is_service }
  menu :if => proc { not current_admin_user.is_service and (current_admin_user.authority_group.nil? ? false : current_admin_user.authority_group.admin_management) }

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at


  index :download_links => false do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :is_service
    column :is_translator
    column :authority_group
    actions
  end

  show do
    attributes_table do
      raw :id
      row :username
      row :first_name
      row :last_name
      row :email
      row :last_sign_in_at
      row :created_at
    end
    active_admin_comments
  end


  form do |f|
    f.inputs "Admin Details" do
      f.input :username
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :first_name
      f.input :last_name
      f.input :is_service
      f.input :is_translator
      f.input :authority_group
    end
    f.actions
  end


  # override controller
  controller do

    def create
      params[:admin_user][:authority_group_id] = AuthorityGroup.first.id  if params[:admin_user][:authority_group_id].blank?
      create!
    end

    ## update with/ without password
    def update_resource(object, attributes)
      update_method = attributes.first[:password].present? ? :update_attributes : :update_without_password
      object.send(update_method, *attributes)
    end
  end

end
