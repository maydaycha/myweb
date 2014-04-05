require 'digest/md5'

class TranslatorsController < ApplicationController

  # skip_before_filter :verify_authenticity_token
  before_filter :set_headers

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

  # def create
  # @translator = Translator.new(params.permit![:translator])
  # @translator.save
  # redirect_to translators_url
  # end

  def create
    if Translator.find_by_account(params[:account])
      render :json => { :status => "fail", :reason => "duplicate" }
    else
      if Translator.signup!(params[:account], params[:password], params[:name], params[:category])
        render :json => { :status => "success" }
      else
        render :json => { :status => "fail" }
      end
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


  def login
    if @translator = Translator.find_by_account(params[:account])
      if Digest::MD5.hexdigest(params[:password]) == @translator['password']
        session[:account] = @translator['account']
        render :json => { :status => "success", :session => session, :token => form_authenticity_token }
      else
        render :json => { :status => "fail", :reason => "password error" }
      end
    else
      render :json => { :status => "fail", :reason => "not such account" }
    end
  end


  def logout
    session.delete(:account)
    render :json => { :status => "success", :session => session[:account] }
  end

  def isLogin
    puts "session"
    puts session[:account]
    if session[:account]
      render :json => { :status => "success", :isLogin => true, :account => session[:account]}
    else
      render :json => { :status => "success", :isLogin => false, :account => session[:account]}
    end
  end

  def csrf_token
    render :json => { :status => "success" , :csrfmiddlewaretoken => form_authenticity_token }, :callback => params[:callback]
  end
end
