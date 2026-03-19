# frozen_string_literal: true

require "test_helper"
require "rails/generators/test_case"
require "generators/fine_print/install_generator"

class FinePrint::InstallGeneratorTest < Rails::Generators::TestCase
  tests FinePrint::Generators::InstallGenerator
  destination File.expand_path("../../tmp/generator_test", __dir__)

  setup do
    prepare_destination
    FileUtils.mkdir_p(File.join(destination_root, "config"))
    File.write(
      File.join(destination_root, "config/routes.rb"),
      "Rails.application.routes.draw do\nend\n"
    )
  end

  test "adds mount line to routes" do
    run_generator
    assert_file "config/routes.rb", /mount FinePrint::Engine, at: "\/legal"/
  end

  test "copies initializer" do
    run_generator
    assert_file "config/initializers/fine_print.rb", /FinePrint\.configure/
  end

  test "copies migrations" do
    run_generator
    assert_migration "db/migrate/create_fine_print_documents.rb"
  end
end
