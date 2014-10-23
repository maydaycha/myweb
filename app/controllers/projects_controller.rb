require 'json'
require "csv"

class ProjectsController < ApplicationController
  protect_from_forgery except: [:add_to_favorite, :remove_from_favorite]
  before_action :set_headers
  before_action :authenticate_user!

  def index
    @projects = Project.all
    @category = ProjectCategory.all
    @translators = Translator.all
    @project_list = []
    # @projects.each do |p|
    # @project_list << JSON::parse(p.to_json).merge("have_public_message" => p.has_public_mesage?)
    # end
    respond_to do |format|
      format.html { render :html => [ @projects, @category, @translators] }
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @project.to_json }
    end
  end

  def update
    @project = Project.find(params[:id])
    @project.update(params.permit![:project])
    redirect_to project_path(@project)
  end

  def new
    @main_skill_id = params[:main].nil? ? -1 : params[:main].to_i
    @sub_skill_id = params[:sub].nil? ? -1 : params[:sub].to_i
    @project = Project.new
  end

  def create
    # return render json: params).read
    @project = Project.new(params.permit![:project])
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Successfully created.' }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path(params[:id])
  end

  def search
    # params[:main], params[:sub]
    @main_skill_id = params[:main].nil? ? -1 : params[:main].to_i
    @sub_skill_id = params[:sub].nil? ? -1 : params[:sub].to_i
    @keyword = params[:keyword].to_s.downcase
    @pay_min = params[:pay_min].to_i
    @pay_max = params[:pay_max].to_i # -1 = 無限大
    @pay_max = (2**(0.size * 8 -2) -1) if @pay_max == -1

    if @main_skill_id == -1 # not specify category
      @projects = Project.all
      # 移除註冊不完全的使用者
      #@projects.delete_if{ |e| e.hourly_pay.nil? }
      # search by keyword
      @projects = Project.where("description LIKE :keyword", {:keyword => "%#{@keyword}%"}) unless @keyword.blank?
    elsif @main_skill_id != -1 and @sub_skill_id == -1 # only specify main_category
      @projects = Project.where(main_skill: @main_skill_id)
      @projects.delete_if{ |e| not e.description.downcase.include? @keyword } unless @keyword.blank?
    else # specify main_category and sub_category
      @projects = Project.where(main_skill: @main_skill_id, sub_skill: @sub_skill_id)
      @projects.delete_if{ |e| not e.description.downcase.include? @keyword } unless @keyword.blank?
    end

    #@users.delete_if{ |e| e.id == current_user.id or @pay_min > e.hourly_pay or e.hourly_pay > @pay_max }

    @total_size = @projects.size
    @projects = Kaminari.paginate_array(@projects).page(params[:page]).per(5)
  end

  def add_to_favorite
    current_user.user_favorite_projects.create!(favorite_project_id: params[:project_id]) unless current_user.user_favorite_projects.exists?(favorite_project_id: params[:project_id])
    render json: current_user.user_favorite_projects
  end

  def remove_from_favorite
    current_user.user_favorite_projects.where(favorite_project_id: params[:project_id]).delete_all
    render json: current_user.user_favorite_projects
  end

  def detail
    @project = Project.find(params[:id])
  end

  def update_budget
    if @projects = Project.where(:project_category => params[:c])
      @projects.each do |ele, index|
        ele.budget = "#{ ele.budget.split(/,/)[0].to_i + params[:new_budget].to_i}, #{ ele.budget.split(/,/)[1].to_i + params[:new_budget].to_i}"
        ele.save
      end
    end
    render :json => { :data => params[:new_budget] , :category => params[:c] }
  end

  def get_project_by_translator
    puts session[:account]
    if session[:account]
      if @translator = Translator.find_by_account(session[:account])
        if @projects = Project.where(:translators => @translator['id'])
          @project_list = []
          @projects.each do |ele, index|
            if @public_message = ProjectPublicMessage.where(:project_id => ele['outside_id']).take
              ele['public_message'] = @public_message
            end
            @project_list << JSON::parse(ele.to_json).merge("have_public_message" => ele.has_public_mesage?)
          end
          render :json => { :status => "success", :data => @project_list }
        end
      end
    else
      render :json => { :status => "fail", :reason => "plase login"}
    end
  end



  def wirte_job_to_csv
    @projects = Project.order(:id)
    respond_to do |format|
      format.html
      format.csv { send_data @projects.to_csv, :type => "application/csv", :filename => "project_list.csv" }
      format.xls { send_data @projects.to_csv(col_sep: "\t") }
    end
  end

  def excel_download
    @projects = Project.order(:id)
    respond_to do |format|
      format.html
      format.xls
    end
  end

  def set_word_count
    @projects = Project.order(:id)
    @projects.each do |p|
      name_word_count = p.name.gsub(/[(,) ]/," ").split(/ /).delete_if {|item| item == '' }
      description_word_count = p.description.gsub(/[(,) ]/," ").split(/ /).delete_if {|item| item == '' }
      p.word_count = name_word_count.length + description_word_count.length
      p.save
    end
    render :json => { :name_count => "123", :data => @temp }
  end


end
