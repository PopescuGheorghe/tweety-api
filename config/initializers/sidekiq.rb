require 'sidekiq-cron'

redis_config = {
  url: "redis://#{ENV['SIDEKIQ_REDIS_HOST']}:#{ENV['SIDEKIQ_REDIS_PORT']}",
  db: ENV['SIDEKIQ_REDIS_DB']
}

Sidekiq.configure_client do |config|
  config.redis = redis_config
  # accepts :expiration (optional)
  Sidekiq::Status.configure_client_middleware config, expiration: 30.days
end

Sidekiq.configure_server do |config|
  config.redis = redis_config
  # accepts :expiration (optional)
  Sidekiq::Status.configure_server_middleware config, expiration: 30.days

  # accepts :expiration (optional)
  Sidekiq::Status.configure_client_middleware config, expiration: 30.days
end
