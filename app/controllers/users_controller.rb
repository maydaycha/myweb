class UsersController < ApplicationController

  def signup
    message = User.signup(params[:first_name], params[:last_name], params[:email], params[:country_code], params[:account], params[:password], params[:how_to_know], params[:receive_information])
    if message['status'] == 'success'
      @user = User.find_by_account(params[:account])
      Emailer.new_record_notification(@user).deliver
    end
    render :json => message
  end

  def test
    a = User.has_email?("scott03333@gmail.com")
  end

  def login
    if User.login(params[:account], params[:password])
      render :json => { :status => "login success"}
    else
      render :json => { :status => "login fail"}
    end
  end

  def send_mail
    @user = User.all.first
    Emailer.new_record_notification(@user).deliver
    render :json => { status: "success"}
  end

  def index
    
  end

end
