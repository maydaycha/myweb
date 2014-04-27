class Users::SkillCategorysController < ApplicationController
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
    redirect_to  edit_users_skill_category_path(@user_skill_category)
    # render :edit
  end

  def edit
    @user_skill_category = UserSkillCategory.find(params[:id])
  end

  def update
    @user_skill_category = UserSkillCategory.find(params[:id])
    @user_skill_category.sub_skill_id = params[:class].join(',')
    @user_skill_category.save
    # render json: {content: params[:class], session: session}
    @user = User.find("1")
    redirect_to new_users_profile_path
  end
end
