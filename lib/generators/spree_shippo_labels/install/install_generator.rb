# frozen_string_literal: true

module SpreeShippoLabels
  module Generators
    class InstallGenerator < Rails::Generators::Base
      class_option :auto_run_migrations, type: :boolean, default: false
    end
  end
end
