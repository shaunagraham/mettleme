
OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "427523017347667", "cf31332cc8f17b8c400962ffdf164141"
  provider :google_oauth2, "456815540419-4i5m8774337ab1c5ssdurgp1g145bhgh.apps.googleusercontent.com", "JEa_VgAmUi4FjPqsb4EAHHFp"
end