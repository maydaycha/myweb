class SkillsController < ApplicationController
  protect_from_forgery except: :autocomplete

  def autocomplete
    escaped_location =  params[:q].gsub('%', '\%').gsub('_', '\_')
    skills = []
    Skill.find(:all, conditions: ["name like ?", escaped_location + "%"]).each{ |e| skills << e }
    Skill.find(:all, conditions: ["name like ?", "%" + escaped_location + '%']).each{ |e| skills << e }
    seen = []
    skills.each{ |e| seen << e if not seen.map(&:name).include? e.name }
    return_string = ""
    seen.each{ |e| return_string += "#{e.name}\n"} if seen
    render :text => return_string
  end

  def import_from_csv
    Skill.import_from_csv
  end

  def exist
    render json: {status: Skill.exists?(:name => params[:name])}
  end

end
