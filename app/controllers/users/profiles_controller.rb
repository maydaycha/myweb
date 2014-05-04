require 'open-uri'
class Users::ProfilesController < ApplicationController
  before_action :authenticate_user!

  protect_from_forgery except: [:ajax_upload_img, :ajax_updae]

  def index
  end

  def new
  end

  def create
    @user.update(params.permit![:user])
    render json: {c: @user}
  end

  def edit
    @user = User.find(params[:id])
  end


  def update
    current_user.user_skills.destroy_all if !current_user.user_skills.empty?
    if current_user.user_skills.empty?
      foeign_skills = []
      params[:user][:user_skills].split(",").each{|e| foeign_skills << current_user.user_skills.create!(name: e) }
    end
    params[:user][:user_skills] = foeign_skills
    current_user.update!(params.permit![:user])
    if params[:image]
      file_type = params[:image].content_type.split("/")[1]
      path = "/upload/#{current_user.username}.#{file_type}"
      File.open("public#{path}", 'wb'){ |f| f << open(params[:image].tempfile).read }
      current_user.image = path
    end
    current_user.step = 2
    current_user.save
    redirect_to users_profile_path(current_user)
  end


  def show
    @skill_main_categoies = current_user.user_skill_categories.uniq_by(&:main_skill_id)
  end


  def ajax_updae
    case params[:request]
    when "update_basic_info"
      current_user.first_name = params[:name].split(/ /)[0]
      current_user.last_name = params[:name].split(/ /)[1]
      current_user.email = params[:email]
      current_user.hourly_pay = params[:money]
      current_user.save
      render json: current_user

    when "update_location"
      current_user.time_zone = params[:timeZone]
      current_user.country_code = params[:country]
      current_user.save
      render json: current_user

    when "update_skill"
      current_user.user_skills.destroy_all if not current_user.user_skills.empty?
      params[:skill].split(",").each{ |e| current_user.user_skills.create!(name: e) }
      render json: current_user

    when "update_experience"
      params[:experience_add_list].each{ |e| current_user.user_experiences.create!(organization: e[:organization], office: e[:office], start_date: e[:start_date], end_date: e[:end_date], description: e[:description])} if not params[:experience_add_list].nil?
      params[:experience_delete_list].each{ |e| UserExperience.destroy(e[:id]) } if not params[:experience_delete_list].nil?
      render json: current_user.user_experiences

    when "update_education"
      params[:education_add_list].each{ |e| current_user.user_educations.create!(school: e[:school], department: e[:department], start_date: e[:start_date], end_date: e[:end_date], description: e[:description])} if not params[:education_add_list].nil?
      params[:education_delete_list].each{ |e| UserEducation.destroy(e[:id]) } if not params[:education_delete_list].nil?
      render json: current_user.user_educations
    end

  end


  def ajax_upload_img
    file_name = current_user.username + "." + request.headers['X-File-Type'].split("/")[1]
    directory = "public/upload"
    path = directory + "/" + file_name
    current_user.picture = path.split('public')[1]
    # current_user.picture = open(params["profile_img"].tempfile).read
    current_user.save
    File.open(path, "wb"){ |f| f << open(params["profile_img"].tempfile).read }
    render json: @user
  end


  def show_image
    @user = User.find(params[:id])
    send_data @user.picture, :type => 'image/png', :disposition => 'inline'
  end

end
