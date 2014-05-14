class UsersController < ApplicationController
  protect_from_forgery except: [:add_to_favorite, :remove_from_favorite]
  before_action :authenticate_user!, :except => [:check_email, :check_username]

  def check_email
    render json: {status: User.has_email?(params[:email])}
  end

  def check_username
    render json: {status: User.has_username?(params[:username])}
  end


  def index
    @users = User.all
  end

  def search_category
  end

  def search
    # params[:main], params[:sub]
    @main_skill_id = params[:main].to_i
    @sub_skill_id = params[:sub].to_i
    @keyword = params[:keyword].to_s
    @pay_min = params[:pay_min].to_i
    @pay_max = params[:pay_max].to_i # -1 = 無限大
    @pay_max = (2**(0.size * 8 -2) -1) if @pay_max == -1

    @users = UserSkillCategory.where(main_skill_id: @main_skill_id, sub_skill_id: @sub_skill_id).map{ |m| User.find(m.user_id) }
    @users.delete_if{ |e| e.id == current_user.id or @pay_min > e.hourly_pay or e.hourly_pay > @pay_max }
    
    @total_size = @users.size
    @users = Kaminari.paginate_array(@users).page(params[:page]).per(5)
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
