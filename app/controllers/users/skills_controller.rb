class Users::SkillsController < ApplicationController
    before_action :authenticate_user!
    
    def index
    end

    def show
    end

    def new
        @user_skill = UserSkill.new
    end

    def create
        # render json: {content: params[:user_skill]}
        @user_skill = UserSkill.create!(params.permit[:user_skill])
        redirect_to edit_users_skill(@user_skill)
    end

    def edit
    end

    def update
    end
end
