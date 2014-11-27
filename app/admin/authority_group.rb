ActiveAdmin.register AuthorityGroup do

  permit_params :name, :admin_management, :multi_language_management, :banner_management, :menu_management, :category_management, :promotion_page_management, :footer_management, :module_management, :search_management, :user_management, :group_management, :payment_management



  menu :if => proc { current_admin_user.authority_group.nil? ? false : current_admin_user.authority_group.group_management }




end
