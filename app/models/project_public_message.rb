class ProjectPublicMessage < ActiveRecord::Base

  def self.get_public_message_by_project(id)
    self.where(:project_id => id).text
  end

end
