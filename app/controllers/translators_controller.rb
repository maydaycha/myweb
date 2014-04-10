require 'digest/md5'

class TranslatorsController < ApplicationController

  # skip_before_filter :verify_authenticity_token
  before_action :set_headers


  def index
    @translators = Translator.all()
    respond_to do |format|
      format.html
      format.json { render :json => @translators.to_json, :callback => params[:callback] }
    end
  end


  def show
    @translator = Translator.find(params[:id])
  end


  def edit
    @translator = Translator.find(params[:id])
  end


  def new
    @translator = Translator.new
  end


  def create
    @translator = params[:translator]
    if Translator.find_by_account(@translator[:account])
      redirect_to new_translator_path, :alert => "dupicate"
    else
      Translator.signup!(@translator['account'], @translator['password'], @translator['name'], params['project_category']['id'])
      redirect_to translators_login_path
    end
  end


  def update
    @translator = Translator.find(params[:id])
    @translator.update(params.permit![:translator])
    redirect_to translator_path(@translator)
  end


  def destroy
    @translator = Translator.find(params[:id])
    @translator.destroy
    redirect_to translators_path
  end


  def getJobCategory
    @category = ProjectCategory.all(:select => "id, name")
    render :json => @category.to_json
  end


  def projects
    checkLogin
    if @projects = Project.where(:translators => session[:transator_id])
    end
  end


  def login
  end


  def authentication
    if @translator = Translator.find_by_account(params[:account])
      session[:transator_id] = @translator.id
      return redirect_to( @translator.password == Digest::MD5.hexdigest(params[:password]) ? translators_projects_path : translators_login_path)
    end
    redirect_to translators_login_path
  end


  def logout
    session.delete(:transator_id)
    redirect_to translators_login_path
  end


  def checkLogin
    return redirect_to translators_login_path if session[:transator_id] == nil
  end


  def edit_project
    checkLogin
    @project = Project.find(params[:id])
  end


  def update_project_and_message
    checkLogin
    @project = Project.find(params[:project][:id])
    @project.name_chinese = params[:project][:name_chinese]
    @project.description_chinese = params[:project][:description_chinese]
    @project.is_translation = 1
    @project.save
    if params[:project][:public_message]
      @public_message = ProjectPublicMessage.find_by_project_id(@project.outside_id)
      @public_message.text_chinese = params[:project][:public_message]
      @public_message.save
    end
    redirect_to translators_projects_path
  end


  def csrf_token
    render :json => { :status => "success" , :csrfmiddlewaretoken => form_authenticity_token }, :callback => params[:callback]
  end



end
