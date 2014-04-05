
Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.on_failure = ThirdPartyLoginController.action(:failure)
  OmniAuth.config.logger = Rails.logger

  provider :facebook, '604013183007004', '624c4fcca5293637eb2c739d7aaf79cd', :scope => 'email,read_stream,publish_stream,user_about_me,user_birthday,offline_access,user_relationships,user_likes,user_education_history,user_hometown,user_relationship_details,user_location,user_website,user_work_history,publish_actions'

  provider :google_oauth2, '786892635648-gqheuekk9g0v835376t68cof3sj93e10.apps.googleusercontent.com', 'ZbAIFBiq_ZqtCWfo5Du0NKXL', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}

end
