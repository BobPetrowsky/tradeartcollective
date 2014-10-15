Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.assets.debug = true
  config.assets.raise_runtime_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = { :address => "localhost", :port => 1025 }

  CLIENT_ID = ENV["CLIENT_ID"]
  CLIENT_SECRET = ENV["CLIENT_SECRET"]
  USE_STAGE = true
  WEPAY = WePay.new(ENV["CLIENT_ID"], ENV["CLIENT_SECRET"], USE_STAGE)

end
