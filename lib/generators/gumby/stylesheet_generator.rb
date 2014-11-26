module Gumby
  module Generators

    class StylesheetGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a Gumby Stylesheet inside the \"app/assets/stylesheets\" folder"

      def generate_stylesheet(name)
        template "starter_stylesheet.sass", "app/assets/stylesheets/#{name}.css.scss"
      end

    end

  end
end
