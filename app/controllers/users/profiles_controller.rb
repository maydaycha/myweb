require 'open-uri'
class Users::ProfilesController < ApplicationController
  before_action :authenticate_user!, :except => [:get_sub_category]

  protect_from_forgery except: [:ajax_upload_img, :ajax_updae, :get_sub_category, :upload_portfolio_picture, :check_password]

  def index
  end

  def new
  end

  def create
    @user.update(params.permit![:user])
    render json: {c: @user}
  end

  def edit
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    @user = User.find(params[:id])
  end


  def update
    UserSkill.where(user_id: current_user.id).delete_all
    
    foeign_skills = []
    params[:user][:user_skills].split(",").each{ |e| foeign_skills << current_user.user_skills.create!(name: e) }
    
    params[:user][:user_skills] = foeign_skills
    params[:user][:picture] = open(params[:image].tempfile).read if params[:image]
    params[:user][:step] = 2

    current_user.update!(params.permit![:user])
    redirect_to users_profile_path(current_user)
  end


  def show
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    @skill_main_categoies = current_user.user_skill_categories.uniq_by(&:main_skill_id)
    @user = current_user
  end


  def ajax_updae
    case params[:request]
    when "update_basic_info"
      current_user.update!(introduction: params[:introduction], review: params[:review], first_name: params[:first_name], last_name: params[:last_name], hourly_pay: params[:money])
      render json: current_user

    when "update_location"
      current_user.time_zone = params[:timeZone]
      current_user.country_code = params[:country]
      current_user.save
      render json: current_user

    when "update_skill"
      UserSkill.where(user_id: current_user.id).delete_all
      params[:skill].split(",").each{ |e| current_user.user_skills.create!(name: e) }
      render json: current_user

    when "update_experience"
      @experience = UserExperience.find(params[:id])
      @experience.update!(start_date: params[:start_date], end_date: params[:end_date], organization: params[:organization], office: params[:office], description: params[:description])
      render json: current_user.user_experiences
    when 'add_experience'
      current_user.user_experiences.create!(organization: params[:organization], office: params[:office], start_date: params[:start_date], end_date: params[:end_date], description: params[:description])
      render json: current_user.user_experiences
    when 'delete_experience'
      UserExperience.delete(params[:id])
      render json: current_user.user_experiences


    when "update_education"
      @education = UserEducation.find(params[:id])
      @education.update!(start_date: params[:start_date], end_date: params[:end_date], school: params[:school], department: params[:department], description: params[:description])
      render json: current_user.user_educations
    when 'add_education'
      current_user.user_educations.create!(school: params[:school], department: params[:department], start_date: params[:start_date], end_date: params[:end_date], description: params[:description])
      render json: current_user.user_educations
    when 'delete_education'
      UserEducation.delete(params[:id])
      render json: current_user.user_educations

    when "update_category"
      UserSkillCategory.where(user_id: current_user.id).delete_all

      used = {}
      params[:data].each do |index, item|
        item[:sub_category].each do |e|
          if !used[item[:main_category]]
            used[item[:main_category]] = {}
          end
          if !used[item[:main_category]][e]
            used[item[:main_category]][e] = true
            current_user.user_skill_categories.create!(main_skill_id: item[:main_category], sub_skill_id: e)
          end
        end
      end
      render json: current_user.user_skill_categories

    when "update_certification"
      @certificate = UserCertification.find(params[:id])
      @certificate.name = params[:name]
      @certificate.source = params[:source]
      @certificate.get_time = params[:get_time]
      @certificate.description = params[:description]
      @certificate.save
      render json: current_user.user_certifications

    when 'add_certification'
      current_user.user_certifications.create!(name: params[:name], source: params[:source], get_time: params[:get_time], description: params[:description])
      render json: current_user.user_certifications

    when 'delete_certification'
      UserCertification.delete(params[:id])
      render json: current_user.user_certifications

    when 'add_portfolio'
      current_user.user_portfolios.create! do |e|
        e.name = params[:name]
        e.description = params[:description]
        e.date = params[:date]
        e.main_skill_id = params[:main_skill_id]
        e.sub_skill_id = params[:sub_skill_id]
        e.skill = params[:skill]
        e.document_name = params[:document_name] unless params[:document_name].nil?
        # e.document_content = open(params[:document_content].tempfile).read unless (params[:document].is_a? String)
        e.document_content = open(params[:document_content].tempfile).read unless params[:document_content].nil?
        e.picture1 = open(params[:file][0].tempfile).read unless params[:file].nil?
      end
      render json: current_user.user_portfolios
    when 'delete_portfolio'
      UserPortfolio.delete(params[:id])
      render json: current_user.user_portfolios

    # when "get_sub_category"
    #   render json: t(:sub_skill_category)[params[:main_category_id].to_i]
    else
      render json: params
    end
  end

  def get_sub_category
    render json: t(:sub_skill_category)[params[:main_category_id].to_i]
  end

  def check_password
    render json: {status: current_user.valid_password?(params[:password])}
  end

  def ajax_upload_img
    current_user.picture = open(params[:profile_img].tempfile).read
    current_user.save
    render json: current_user
  end

  # def ajax_verify_password
  #   puts current_user.valid_password?(params[:current_password])
  #   render json: {status: current_user.valid_password?(params[:current_password])}
  # end

  def upload_portfolio_picture
    render json: params
  end


  def show_image
    if user_signed_in?
      user = User.find(params[:id])
      if user.picture == nil
        render :text => open("public/img/staff.png", "rb").read
      else
        send_data user.picture, :type => 'image/png', :disposition => 'inline'
      end
    else
      render root_path
    end
  end

  def show_portfolio_image
    if params[:id].nil?
      @user = current_user
    else
      @user = User.find(params[:id])
    end
    if @user.user_portfolios[params[:index].to_i].picture1 == nil
      render :text => open("public/img/staff.png", "rb").read
    else
      send_data @user.user_portfolios[params[:index].to_i].picture1, :type => 'image/png', :disposition => 'inline'
    end
  end


end
