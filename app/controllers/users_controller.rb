class UsersController < ApplicationController

  def signup

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

end
