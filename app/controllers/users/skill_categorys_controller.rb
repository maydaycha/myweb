class Users::SkillCategorysController < ApplicationController
  before_action :authenticate_user!
  
  def index
  end

  def show
  end

  def new
    @user_skill_category = UserSkillCategory.new
  end

  def create
    # need find user from session
    # return render json: {content: params[:user_skill_category]}
    @user = User.find("1")
    session[:user_id] = @user.id
    @user_skill_category = UserSkillCategory.new(params.permit![:user_skill_category])
    @user_skill_category.user_id = @user.id
    @user_skill_category.save
    @category =  ["IT", "engineeringScience", "designCreativeWork", "salesMarketing", "administrativeCustomerServices",  "businessAccountingLegal", "writingTranslation", "consulting" ]
    index = params["user_skill_category"]["main_skill_id"].to_i - 1
    @main_category = "main_skill_category.#{@category[index]}"
    @sub_category = "sub_skill_category.#{@category[index]}"
    # edit_users_skill_category_path(@user_skill_category, @category)
    edit(@user_skill_category, @main_category, @sub_category)
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
