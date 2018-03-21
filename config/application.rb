require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Fels239
  class Application < Rails::Application
    config.load_defaults 5.1
    config.time_zone = "Asia/Ho_Chi_Minh"
    config.active_record.default_timezone = :local
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}")]
    config.i18n.available_locales = [:vi, :en]
    config.i18n.default_locale = :en
    config.active_job.queue_adapter = :sidekiq
  end
end
