class UsersController < ApplicationController
  protect_from_forgery except: [:add_to_favorite, :remove_from_favorite]

  def check_email
    render json: {status: User.has_email?(params[:email])}
  end

  def check_username
    render json: {status: User.has_username?(params[:username])}
  end

  def search
  end

  def index
    @users = User.all
  end

  def browse_by_skill_category
  end

  def search_result
    @users = UserSkillCategory.where(main_skill_id: params[:main], sub_skill_id: params[:sub]).map{ |m| User.find(m.user_id) }
    # exclude myself
    @users.delete_if{ |e| e.id == current_user.id }
    @total_size = @users.size
    @users = Kaminari.paginate_array(@users).page(params[:page]).per(1)
  end

  def detail
    @user = User.find(params[:id])
  end

  def add_to_favorite
    if current_user.user_favorites.where(favorite_user_id: params[:user_id])
      current_user.user_favorites.create!(favorite_user_id: params[:user_id])
    end
    render json: current_user.user_favorites
  end

  def remove_from_favorite
    current_user.user_favorites.where(favorite_user_id: params[:user_id]).destroy_all
    render json: current_user.user_favorites
  end

end
