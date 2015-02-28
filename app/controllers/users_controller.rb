class UsersController < ApplicationController
  protect_from_forgery except: [:add_to_favorite, :remove_from_favorite]
  before_action :authenticate_user!, :except => [:check_email, :check_username, :search]

  def check_email
    render json: {status: User.has_email?(params[:email])}
  end

  def check_username
    render json: {status: User.has_username?(params[:username])}
  end

  def index
    # @users = User.all
    @favourite_list = []

    User.first.user_favorites.each { |f| @favourite_list << User.find(f.user_id) }
    render json: @favourite_list
  end


  def search_category
  end

  def freelencer_find
    @user = User.find(params[:id])
  end

  def freelencer_job
    @user = User.find(params[:id])
  end

  def search
    # check if need user login first
    @searchManagement = SearchManagement.where(category: :freelancer).first
    if not @searchManagement.nil?
      if not @searchManagement.allow_external
        authenticate_user!
      end
    end

    # params[:main], params[:sub]
    @main_skill_id = params[:main].nil? ? -1 : params[:main].to_i
    @sub_skill_id = params[:sub].nil? ? -1 : params[:sub].to_i
    @keyword = params[:keyword].to_s.downcase
    @pay_min = params[:pay_min].to_i
    @pay_max = params[:pay_max].to_i # -1 = 無限大
    @pay_max = (2**(0.size * 8 -2) -1) if @pay_max == -1

    if @main_skill_id == -1 # not specify category
      @users = User.all
      # 移除註冊不完全的使用者
      @users.delete_if{ |e| e.hourly_pay.nil? }
      # search by keyword
      @users = User.where("introduction LIKE :keyword", {:keyword => "%#{@keyword}%"}) unless @keyword.blank?
    elsif @main_skill_id != -1 and @sub_skill_id == -1 # only specify main_category
      @users = UserSkillCategory.where(main_skill_id: @main_skill_id).group("user_id").map{ |m| User.find(m.user_id) }
      @users.delete_if{ |e| not e.introduction.downcase.include? @keyword } unless @keyword.blank?
    else # specify main_category and sub_category
      @users = UserSkillCategory.where(main_skill_id: @main_skill_id, sub_skill_id: @sub_skill_id).map{ |m| User.find(m.user_id) }
      @users.delete_if{ |e| not e.introduction.downcase.include? @keyword } unless @keyword.blank?
    end

    @users.delete_if{ |e| e.id == current_user.id or @pay_min > e.hourly_pay or e.hourly_pay > @pay_max } if not current_user.nil?

    @total_size = @users.size
    @users = Kaminari.paginate_array(@users).page(params[:page]).per(5)
  end


  def add_to_favorite
    current_user.user_favorites.create!(favorite_user_id: params[:user_id]) unless current_user.user_favorites.exists?(favorite_user_id: params[:user_id])
    render json: current_user.user_favorites
  end

  def remove_from_favorite
    current_user.user_favorites.where(favorite_user_id: params[:user_id]).delete_all
    render json: current_user.user_favorites
  end

  def detail
    @user = User.find(params[:id])
  end

end
