class Users::SkillCategorysController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
  end

  def new
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    if not params[:user_skill_category]
      render template: "users/skill_categorys/new"
    else
      new2(params[:user_skill_category])
    end
  end

  def new2(user_skill_category)
    @category =  ["IT", "engineeringScience", "designCreativeWork", "salesMarketing", "administrativeCustomerServices",  "businessAccountingLegal", "writingTranslation", "consulting" ]
    index = params["user_skill_category"]["main_skill_id"].to_i
    @category_index = index
    render "new2", locals: { user_skill_category_id: params[:user_skill_category]['main_skill_id'] }
  end

  def create
    current_user.user_skill_categories.destroy_all if not current_user.user_skill_categories.empty?
    params[:class].each do |c|
      @user_skill_category = UserSkillCategory.new
      @user_skill_category.main_skill_id = params[:user_skill_category_id]
      @user_skill_category.sub_skill_id = c
      @user_skill_category.user_id = current_user.id
      @user_skill_category.save
    end
    current_user.step = 1
    current_user.save
    redirect_to edit_users_profile_path(current_user)
  end




  def edit(user_skill_category, main_category, sub_category)
    # @user_skill_category = UserSkillCategory.find(params[:id])
    @user_skill_category = user_skill_category
    @main_category = main_category
    @sub_category = sub_category
    render "edit"
  end


  def update
    @user_skill_category = UserSkillCategory.find(params[:id])
    @user_skill_category.sub_skill_id = params[:class].join(',')
    @user_skill_category.save
    # render json: {content: params[:class], session: session}
    @user = User.find("1")
    redirect_to edit_users_profile_path(@user)
  end
end
