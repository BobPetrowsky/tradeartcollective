Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["APP_ID"], ENV["APP_SECRET"],
    :scope => 'email, user_location', image_size: {width: 200, height: 200}
end
