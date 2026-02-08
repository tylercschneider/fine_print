# frozen_string_literal: true

module FinePrint
  module Signable
    extend ActiveSupport::Concern

    included do
      FinePrint.config.agreements.each do |agreement|
        belongs_to :"accepted_#{agreement.document_type}_version",
          class_name: "FinePrint::Document",
          optional: true
      end
    end

    def needs_acceptance?(agreement)
      agreement.not_accepted_by?(self)
    end

    def accept_version!(agreement, version)
      update!(agreement.version_column => version.id)
    end
  end
end
