# frozen_string_literal: true

module FinePrint
  class Configuration
    attr_accessor :agreements
    attr_accessor :current_user_method
    attr_accessor :signed_in_method
    attr_accessor :auth_controller_method
    attr_accessor :sign_out_method

    def initialize
      @agreements = []

      @current_user_method = ->(c) { c.current_user }
      @signed_in_method = ->(c) { c.user_signed_in? }
      @auth_controller_method = ->(c) { c.respond_to?(:devise_controller?) && c.devise_controller? }
      @sign_out_method = ->(c) {
        if defined?(Devise) && Devise.sign_out_all_scopes
          c.sign_out
        else
          c.sign_out(c.current_user)
        end
      }
    end

    def current_user(controller) = current_user_method.call(controller)
    def signed_in?(controller) = signed_in_method.call(controller)
    def auth_controller?(controller) = auth_controller_method.call(controller)
    def sign_out(controller) = sign_out_method.call(controller)
  end
end
