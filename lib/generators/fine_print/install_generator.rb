# frozen_string_literal: true

require "rails/generators"

module FinePrint
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      desc "Installs FinePrint: adds route, copies initializer and migrations."

      def mount_engine
        route 'mount FinePrint::Engine, at: "/legal"'
      end
    end
  end
end
