class Users::Employer::Personal::ProfilesController < ApplicationController
  def show
    render json: {test: :hi}
  end

  def new
  end

  def create
  end

  def edit
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    @personal = current_user.user_employer_personals
    render json: @personal
  end

  def update
  end

end
