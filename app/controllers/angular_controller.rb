require 'digest/md5'
class AngularController < ApplicationController

  # skip_before_filter :verify_authenticity_token
  before_filter :set_headers
  #josnp
  def index
    render :json => {:name => "maydaycha"}, :callback => params[:callback]
  end

  def create
    # set_headers
    @t = Translator.find_by_account(params[:account])
    if @t
      render :json => { :status => "fail", :reason => "duplicate" }
    else
      begin
        @translator = Translator.create(
          :account => params[:account],
          :password => Digest::MD5.hexdigest(params[:password]),
          :name => params[:name],
          :category => params[:category]
          )
        render :json => { :status => "success" }
      rescue
        render :json => { :status => "fail" }
      end
    end
  end

  def getJobCategory
    # set_headers
    @category = ProjectCategory.all(:select => "id, name")
    render :json => @category.to_json
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

  def login
    if session[:account]
      render :json => { :status => "haved login", :session => session[:account]}
    else
      @t = Translator.find_by_account(params[:account])
      puts @t
      puts params[:account]
      if @t
        if Digest::MD5.hexdigest(params[:password]) == @t['password']
          session[:account] = @t['account']
          render :json => { :status => "success", :cookie => session, :token => form_authenticity_token }
        else
          render :json => { :status => "success", :reason => "password error" }
        end
      else
        render :json => { :status => "success", :reason => "not such account" }
      end
    end
  end

  def logout
    session.delete(:account)
    session.delete('account')
    render :json => { :status => "success", :session => session[:account] }
  end

  def csrf_token
    render :json => { :status => "success" , :csrfmiddlewaretoken => form_authenticity_token }, :callback => params[:callback]
  end

end
