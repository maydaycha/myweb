# encoding: utf-8

ActiveAdmin.register User do

  permit_params :id, :useranme, :picture

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


  # form do |f|
  #   f.inputs "User" do
  #     f.input :username
  #     f.input :email
  #   end
  #   f.inputs "Skill Categorirs" do
  #     f.has_many :user_skill_categories do |c|
  #       c.input :main_skill_id, label: 'Main skill category', as: :select, collection: t(:main_skill_category).each_with_index.map{ |e, i| ["#{e['name']}", i] }
  #       # c.input :sub_skill_id, label: "Sub skill category", as: :select, collection: t(:sub_skill_category)[c.main_skill_id].each_with_index.map{ |e, i| ["#{e['name']}", i] }
  #     end
  #   end
  #   f.actions
  # end

  form :partial => "form"
  # form :partial => "form", :only => [:edit]

  # override controller
  controller do
    def edit
      @user = User.find(params[:id])
      # render form :partial => "form"
    end

    def update
      render json: params
      # @user = User.find(params[:id])
      # UserSkill.where(user_id: @user.id).delete_all
      # params[:skill].split(",").each{ |e| @user.user_skills.create!(name: e) }

      # super
    end
  end




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

end
