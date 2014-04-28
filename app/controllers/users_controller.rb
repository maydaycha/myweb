class UsersController < ApplicationController
  def check_email
  	render json: {status: User.has_email?(params[:email])}
  end

  def check_username
  	render json: {status: User.has_username?(params[:username])}
  end
end
