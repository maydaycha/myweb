class UsersController < ApplicationController

  def signup

  end

  def test
  	a = User.has_email?("scott03333@gmail.com")
  end
end