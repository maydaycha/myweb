# encoding: utf-8

ActiveAdmin.register User do
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
        user.user_skill_categories.map{ |s| "#{t(:main_skill_category)[s.main_skill_id.to_i]['name']}: #{t(:sub_skill_category)[s.main_skill_id.to_i][s.sub_skill_id.to_i]['name']}" }.join(",  ")
      end
      row "skill" do
        user.user_skills.map{ |s| s.name }.join(", ")
      end
    end
    active_admin_comments
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
