class AddFinePrintToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :accepted_terms_of_service_version_id, :bigint
    add_column :users, :accepted_privacy_policy_version_id, :bigint
    add_foreign_key :users, :fine_print_documents, column: :accepted_terms_of_service_version_id
    add_foreign_key :users, :fine_print_documents, column: :accepted_privacy_policy_version_id
  end
end
