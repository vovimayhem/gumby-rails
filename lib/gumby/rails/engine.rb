module Gumby
  module Rails
    class Engine < ::Rails::Engine

      initializer "gumby.assets.precompile" do |app|

        # Agregar jquery.mobile custom para gumby:
        app.config.assets.precompile.push "jquery.mobile.gumby.min.js"

        # Agregar los fonts al asset pipeline:
        app.config.assets.precompile.push Gumby::Rails.precompile

      end

    end

    def self.precompile
      @precompile ||= Proc.new do |path|
        File.extname(path).in? %w(.eot .otf .svc .woff .ttf)
      end
    end
  end
end
