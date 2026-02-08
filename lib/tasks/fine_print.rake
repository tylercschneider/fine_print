namespace :fine_print do
  desc "Seed initial legal document versions for each configured agreement"
  task seed: :environment do
    puts "Seeding legal documents..."

    FinePrint.config.agreements.each do |agreement|
      if FinePrint::Document.where(document_type: agreement.document_type).exists?
        puts "  #{agreement.title} v1.0 already exists, skipping"
      else
        FinePrint::Document.create!(
          document_type: agreement.document_type,
          version: "1.0",
          summary: "Initial #{agreement.title.downcase}",
          content: "<h2>#{agreement.title}</h2><p>This is a placeholder. Please update with your actual #{agreement.title.downcase}.</p>",
          effective_at: Time.current
        )
        puts "  Created #{agreement.title} v1.0"
      end
    end

    puts "Done!"
  end
end
