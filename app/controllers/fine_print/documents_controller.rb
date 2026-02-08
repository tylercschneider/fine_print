# frozen_string_literal: true

module FinePrint
  class DocumentsController < ::ApplicationController
    def terms
      @agreement = FinePrint.config.agreements.find { |a| a.id == :terms_of_service }
      @version = FinePrint::Document.current(:terms_of_service)
    end

    def privacy
      @agreement = FinePrint.config.agreements.find { |a| a.id == :privacy_policy }
      @version = FinePrint::Document.current(:privacy_policy)
    end
  end
end
