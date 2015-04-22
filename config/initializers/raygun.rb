if Rails.env.production?
  Raygun.setup do |config|
    config.api_key = "gbNnh4rHlqljX3JqYx4++A=="
    config.filter_parameters = Rails.application.config.filter_parameters
  end
end
