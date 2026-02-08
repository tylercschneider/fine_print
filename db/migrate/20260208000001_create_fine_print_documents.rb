class CreateFinePrintDocuments < ActiveRecord::Migration[8.0]
  def change
    create_table :fine_print_documents do |t|
      t.string :document_type, null: false
      t.string :version, null: false
      t.datetime :effective_at
      t.text :summary

      t.timestamps
    end

    add_index :fine_print_documents, [:document_type, :version], unique: true
    add_index :fine_print_documents, [:document_type, :effective_at]
  end
end
