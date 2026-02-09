# frozen_string_literal: true

module FinePrint
  class Engine < ::Rails::Engine
    isolate_namespace FinePrint

    initializer "fine_print.url_helpers" do
      ActiveSupport.on_load(:action_controller) do
        helper Rails.application.routes.url_helpers
      end
    end
  end
end
