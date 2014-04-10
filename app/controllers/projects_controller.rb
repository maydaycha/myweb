require 'json'
require "csv"

class ProjectsController < ApplicationController

  before_action :set_headers

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

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path
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

  def update_project_from_angular
    if params[:projectName] && params[:projectDescription] && params[:projectId]
      @p = Project.find(params[:projectId])
      @p.name_chinese = params[:projectName]
      @p.description_chinese = params[:projectDescription]
      @p.is_translation = 1
      @p.save
      render :json => { :status => "success" }
    else
      render :json => { :status => "fail" }
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
