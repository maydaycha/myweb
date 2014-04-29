require 'open-uri'
class Users::ProfilesController < ApplicationController
  before_action :authenticate_user!

  protect_from_forgery except: [:ajax_upload_img, :ajax_updae]

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
  end



  def update
    @user = User.find(params[:id])
    @user.update(params.permit![:user])
    # redirect_to edit2event_path(@user)
    # render json: {content: @user}
    render :show
  end

  # def edit2
  # @user = User.find(session[:user_id])
  # end

  # def update2
  # end


  def show
    puts current_user.to_json
    @user = User.find(current_user['id'])
  end


  def ajax_updae
    @user = User.find(current_user['id'])
    case params[:request]
    when "update_basic_info"
      @user.first_name = params[:name].split(/ /)[0]
      @user.last_name = params[:name].split(/ /)[1]
      @user.email = params[:email]
      # @user.email = "maydaychaaaa@gmail.com"
      @user.save

      puts @user.to_json
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
    when "profile_img"
      render json: params
    end
  end



  def ajax_upload_img
    @user = User.find(current_user['id'])
    file_name = @user.username + "." + request.headers['X-File-Type'].split("/")[1]
    directory = "public/upload"
    path = directory + "/" + file_name

    @user.image = path
    @user.save
    puts path

    File.open(path, "wb") do |f|
      f << open(params["profile_img"].tempfile).read
    end



    render json: @user
  end

end
