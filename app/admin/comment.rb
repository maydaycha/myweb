# include ActiveAdmin::Comments::ShowPageHelper
# include ActiveAdmin::Comments::Views
ActiveAdmin.register Comment do

  # after_create do |comment|
  #   puts "after create!!!"
  #   # AdminMailer.comment_created(comment.id).deliver
  # end
  # after_action :authenticate_user!

  # after_create :sendcomment_mail

  controller do

    def create
      params[:active_admin_comment][:namespace] = "admin"
      params[:active_admin_comment][:author_id] = current_user.id
      params[:active_admin_comment][:author_type] = params[:active_admin_comment][:resource_type]
      @comment = Comment.create!(params.permit![:active_admin_comment])
      @user = User.find(params[:active_admin_comment][:resource_id])
      Emailer.new_record_notification(@user, @comment).deliver
      redirect_to admin_user_path(params[:active_admin_comment][:resource_id])
    end

    # def sendcomment_mail
    #   puts "ho"
    #   # mail(to: self.email, subject: "Welcome Message")
    # end

  end


  index do
    column t(:id) do |m|
      link_to m.id, admin_comment_path(m.id)
    end
    column :namespace
    column :body
    actions
  end



  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end



end
