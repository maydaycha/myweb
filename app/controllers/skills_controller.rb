class SkillsController < ApplicationController
  protect_from_forgery except: :autocomplete

  def autocomplete
    escaped_location =  params[:q].gsub('%', '\%').gsub('_', '\_')
    skills = Skill.find(:all, conditions: ["name like ?", escaped_location + "%"])
    return_string = ""
    skills.each{ |e| return_string += "#{e.name}\n"} if skills
    render :text => return_string
  end

  def import_from_csv
    Skill.import_from_csv
  end

end
