# encoding: utf-8
ActiveAdmin.register User do

  # permit_params :id, :useranme, :picture


  filter :email
  filter :username
  filter :first_name
  filter :last_name
  filter :last_sign_in_at

  menu :if => proc { current_admin_user.authority_group.nil? ? false : current_admin_user.authority_group.user_management }


  config.clear_action_items!

  action_item :only => [:index] do
    link_to t("active_admin.new_model", model: :User), url: new_admin_user_path unless current_admin_user.is_service?
  end



  index :download_links => false do
    column t(:id) do |m|
      link_to m.id, admin_user_path(m.id)
    end
    column :username
    column :first_name
    column :last_name
    column :email
    column :last_sign_in_at
    column :created_at
    column :actions do |user|
      links = link_to(I18n.t('active_admin.view'), admin_user_path(user)) + "  "
      links += link_to(I18n.t('active_admin.edit'), edit_admin_user_path(user)) + "  "
      links += link_to I18n.t('active_admin.delete'), admin_user_path(user), method: :delete, confirm: 'Are you sure?' unless current_admin_user.is_service?
      links
    end
  end

  show do |user|
    attributes_table do
      row :id
      row :username
      row :first_name
      row :last_name
      row :email
      row :last_sign_in_at
      row :created_at
      row "skill categories" do
        user.user_skill_categories.map{ |s| "#{t(:main_skill_category)[s.main_skill_id]['name']}: #{t(:sub_skill_category)[s.main_skill_id][s.sub_skill_id]['name']}" }.join(",  ")
      end
      row "skill" do
        user.user_skills.map{ |s| s.name }.join(", ")
      end
    end
    active_admin_comments
  end

  form :partial => "form"
  # form :partial => "form", :only => [:edit]


  # override controller
  controller do
    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      # skill
      UserSkill.where(user_id: @user.id).delete_all
      params[:skill].split(",").each{ |e| @user.user_skills.create!(name: e) }

      #category
      if not params[:main_skill_id].nil?
        UserSkillCategory.where(user_id: @user.id).delete_all
        used = {}
        params[:main_skill_id].each_with_index do |e, i|
          if not used[e]
            used[e] = {}
          end
          if not used[e][params[:sub_skill_id][i]]
            used[e][params[:sub_skill_id][i]] = true
            @user.user_skill_categories.create!(main_skill_id: e, sub_skill_id: params[:sub_skill_id][i])
          end
        end
      end

      #basic info
      @user.update!(params.permit![:user])

      super
    end

    def create
      create! unless current_admin_user.is_service?
    end

    def new
      new! unless current_admin_user.is_service?
    end

  end



end
