require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)
require "fine_print"

module Dummy
  class Application < Rails::Application
    config.load_defaults Rails::VERSION::STRING.to_f
    config.eager_load = false
    config.root = File.expand_path("..", __dir__)

    config.active_storage.service = :test
  end
end
