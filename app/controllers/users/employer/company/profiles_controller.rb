class Users::Employer::Company::ProfilesController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery except: [:ajax_updae, :ajax_upload_img]

  def show
    @company = current_user.user_employer_companies.last
  end

  def new
  end

  def create
  end

  def edit
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    @company = current_user.user_employer_companies.last
  end

  def update
    @company = UserEmployerCompany.find(params[:id])
    params[:user][:picture] = open(params[:image].tempfile).read if params[:image]
    @company.update!(params.permit![:user])
    redirect_to users_employer_company_profile_path(@company)
  end

  def show_image
    if user_signed_in?
      company = UserEmployerCompany.find(params[:id])
      if company.picture == nil
        send_file "public/img/staff.png"
      else
        send_data company.picture, :type => 'image/png', :disposition => 'inline'
      end
    else
      render root_path
    end
  end

  def ajax_updae
    case params[:request]
    when "update_basic_info"
      current_user.update!(params.permit![:user])
      company = UserEmployerCompany.find(params[:company][:id])
      company.update!(params.permit![:company])
      render json: {user: current_user, company: company}
    end
  end


  def ajax_upload_img
    company = UserEmployerCompany.find(params[:company][:id])
    company.picture = open(params[:profile_img].tempfile).read
    company.save
    render json: company
  end

end
