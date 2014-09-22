class Users::Employer::Personal::ProfilesController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery except: [:ajax_updae, :ajax_upload_img]

  def show
    @personal = current_user.user_employer_personals.last
  end

  def new
  end

  def create
  end

  def edit
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    @personal = current_user.user_employer_personals.last
  end

  def update
    @personal = UserEmployerPersonal.find(params[:id])
    params[:user][:picture] = open(params[:image].tempfile).read if params[:image]
    @personal.update!(params.permit![:user])
    redirect_to users_employer_personal_profile_path(@personal)
  end

  def show_image
    if user_signed_in?
      personal = UserEmployerPersonal.find(params[:id])
      if personal.picture == nil
        send_file "public/img/staff.png"
      else
        send_data personal.picture, :type => 'image/png', :disposition => 'inline'
      end
    else
      render root_path
    end
  end

  def ajax_updae
    case params[:request]
    when "update_basic_info"
      current_user.update!(params.permit![:user])
      personal = UserEmployerPersonal.find(params[:personal][:id])
      personal.update!(params.permit![:personal])
      render json: {user: current_user, personal: personal}
    end
  end

  def ajax_upload_img
    personal = UserEmployerPersonal.find(params[:personal][:id])
    personal.picture = open(params[:profile_img].tempfile).read
    personal.save
    render json: personal
  end

end
