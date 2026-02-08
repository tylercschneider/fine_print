require "test_helper"

class FinePrint::Admin::DocumentsTest < ActionDispatch::IntegrationTest
  test "can view documents list" do
    version = FinePrint::Document.create!(
      document_type: "terms_of_service",
      version: "1.0",
      content: "Test content",
      effective_at: 1.day.ago
    )

    get fine_print.admin_documents_path
    assert_response :success
    assert_match version.version, response.body
  end

  test "can create new document" do
    get fine_print.new_admin_document_path
    assert_response :success

    assert_difference "FinePrint::Document.count" do
      post fine_print.admin_documents_path, params: {
        document: {
          document_type: "terms_of_service",
          version: "2.0",
          content: "New terms content",
          summary: "Updated liability section"
        }
      }
    end

    assert_redirected_to fine_print.admin_document_path(FinePrint::Document.last)
  end

  test "can publish a draft by setting effective_at" do
    version = FinePrint::Document.create!(
      document_type: "privacy_policy",
      version: "1.0",
      content: "Draft content",
      effective_at: nil
    )

    patch fine_print.admin_document_path(version), params: {
      document: {
        effective_at: Time.current
      }
    }

    assert_redirected_to fine_print.admin_document_path(version)
    version.reload
    assert version.effective_at.present?
  end

  test "can delete a document" do
    version = FinePrint::Document.create!(
      document_type: "terms_of_service",
      version: "1.0",
      content: "Content",
      effective_at: 1.day.ago
    )

    assert_difference "FinePrint::Document.count", -1 do
      delete fine_print.admin_document_path(version)
    end

    assert_redirected_to fine_print.admin_documents_path
  end
end
