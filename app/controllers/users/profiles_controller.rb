class Users::ProfilesController < ApplicationController

  def index
  end

  def new
    # @user = User.find(session[:user_id])
  end

  def create
    @user.update(params.permit![:user])
    render json: {c: @user}
  end

  def edit
    @user = User.find(params[:id])
    # return render json: {content: @user}
  end



  def update
    @user = User.find(params[:id])
    @user.update(params.permit![:user])
    # redirect_to edit2event_path(@user)
    # render json: {content: @user}
    render :show
  end

  def edit2
    @user = User.find(session[:user_id])
  end

  def update2
  end


  def show
    @user = User.find(session[:user_id])
  end

  def ajax_updae
    @user = User.find(session[:user_id])
    case params[:request]
    when "update_basic_info"
      @user.first_name = params[:name].split(/ /)[0]
      @user.last_name = params[:name].split(/ /)[1]
      @user.email = params[:email]
      @user.save
      render json: @user
    when "update_location"
      @user.time_zone = params[:timeZone]
      @user.country_code = params[:country]
      @user.save
      render json: @user
    when "update_skill"
      @user.skill = params[:skill]
      @user.save
      render json: @user
    end
  end



  def ajax_upload_img
    render json: {c: params}
  end

end
