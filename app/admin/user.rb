# encoding: utf-8
ActiveAdmin.register User do
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :id, :useranme, :picture
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

  # permit_params :id, :useranme, :picture

  index do
    column t(:id) do |m|
      link_to m.id, admin_user_path(m.id)
    end
    column :username
    column :first_name
    column :last_name
    column :email
    column :last_sign_in_at
    column :created_at
    actions
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

      #basic info
      @user.update!(params.permit![:user])

      super
    end

  end



end
