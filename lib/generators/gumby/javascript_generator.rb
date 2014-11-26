module Gumby
  module Generators

    class JavascriptGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a Sprockets Javascript file with Gumby inside the \"app/assets/javascripts\" folder"

      def generate_stylesheet(name)
        template "starter_stylesheet.sass", "app/assets/stylesheets/#{name}.css.scss"
      end

    end

  end
end
