Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.on_failure = ThirdPartyLoginController.action(:failure)
  OmniAuth.config.logger = Rails.logger
end
