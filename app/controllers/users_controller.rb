class UsersController < ApplicationController

  def check_email
    render json: {status: User.has_email?(params[:email])}
  end

  def check_username
    render json: {status: User.has_username?(params[:username])}
  end

  def index
    @users = User.all
  end

  def browse_by_skill_category
  end

  def search_result
    @users = UserSkillCategory.where(main_skill_id: params[:main], sub_skill_id: params[:sub]).map{ |m| User.find(m.user_id) }
    @users = Kaminari.paginate_array(@users).page(params[:page]).per(1)
  end

  def detail
    @user = User.find(params[:id])
  end


end
