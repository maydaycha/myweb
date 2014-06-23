ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :username, :first_name, :last_name, :is_service

  # hide resource from menu
  menu :if => proc{ not current_admin_user.is_service }


  index :download_links => false do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :is_service
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

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :username
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :first_name
      f.input :last_name
      f.input :is_service
    end
    f.actions
  end

  controller do
    def create
      create!
    end
  end

end
