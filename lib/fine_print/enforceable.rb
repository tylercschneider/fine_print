# frozen_string_literal: true

module FinePrint
  module Enforceable
    extend ActiveSupport::Concern

    included do
      before_action :require_accepted_agreements!,
        if: -> { request.get? && FinePrint.config.signed_in?(self) && !FinePrint.config.auth_controller?(self) }
    end

    def require_accepted_agreements!
      FinePrint.config.agreements.select(&:prompt_when_updated).each do |agreement|
        if agreement.not_accepted_by?(FinePrint.config.current_user(self))
          store_location_for(:user, request.fullpath) unless request.fullpath.start_with?("/agreements/")
          redirect_to fine_print.agreement_path(agreement)
          break
        end
      end
    end
  end
end
