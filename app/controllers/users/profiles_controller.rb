class Users::ProfilesController < ApplicationController

  def index
  end

  def new
  end

  def create
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(params.permit![:user])
    # redirect_to event_path(@user)
    render json: {content: @user}
  end

  def show
    @user = User.find(params[:id])
  end


end
