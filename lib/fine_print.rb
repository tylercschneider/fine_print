# frozen_string_literal: true

require_relative "fine_print/version"
require_relative "fine_print/configuration"
require_relative "fine_print/agreement"

module FinePrint
  class << self
    def config
      @config ||= Configuration.new
    end

    def configure
      yield config
    end
  end
end

require_relative "fine_print/engine"
require_relative "fine_print/signable"
