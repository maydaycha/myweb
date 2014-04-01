Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '604013183007004', '624c4fcca5293637eb2c739d7aaf79cd', :scope => 'email,read_stream,publish_stream,user_about_me,user_birthday,offline_access,user_relationships,user_likes,user_education_history,user_hometown,user_relationship_details,user_location,user_website,user_work_history,publish_actions'

  OmniAuth.config.on_failure = FacebookController.action(:failure)
end
