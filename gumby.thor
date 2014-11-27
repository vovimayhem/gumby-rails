require "git"

class Gumby < Thor

  include Thor::Actions

  desc "update GUMBY_VERSION", "Update & Modify Gumby Source Files"
  def update(gumby_version = nil)

    gumby_source_path = File.join File.dirname(__FILE__), "gumby-src"

    gumby_repo = if Dir.exists? gumby_source_path
      Git.open  gumby_source_path
    else
      Git.clone "https://github.com/GumbyFramework/Gumby.git", "gumby-src",
                path: File.dirname(__FILE__)
    end

    gumby_repo.checkout :master
    gumby_repo.pull

    # Traerse la última version tageada, si no existe:
    gumby_version = gumby_repo.tags.last.name if gumby_version.nil?

    gumby_repo.checkout gumby_version

    assets_path       = File.join File.dirname(__FILE__), "vendor", "assets"
    fonts_path        = File.join assets_path, "fonts"
    javascripts_path  = File.join assets_path, "javascripts"
    stylesheets_path  = File.join assets_path, "stylesheets"

    FileUtils.mkdir_p [fonts_path, javascripts_path, stylesheets_path]

    # Copy files to vendor/assets directories:

    ############################################################################
    # 1: Clean and re-copy the fonts folder:
    FileUtils.rm_r fonts_path, force: true
    FileUtils.cp_r File.join(gumby_source_path, "fonts"), assets_path

    ############################################################################
    # 2: Clean and re-copy the javascripts folder:}
    FileUtils.rm_r Dir[File.join(javascripts_path, "*")], force: true

    js_files = %w(gumby.js gumby.init.js ui jquery.mobile.custom.min.js).map do |f|
      File.join gumby_source_path, "js", "libs", f
    end

    FileUtils.cp_r js_files, javascripts_path

    FileUtils.move  File.join(javascripts_path, "jquery.mobile.custom.min.js"),
                    File.join(javascripts_path, "jquery.mobile.gumby.min.js")

    # Replace:
    # - yep: Gumby.touchEvents+'/jquery.mobile.custom.min.js'
    # with:
    # - yep: "<%= asset_path('jquery.mobile.custom.min.js') %>"
    # at vendor/assets/javascripts/gumby.init.js
    FileUtils.move  File.join(javascripts_path, "gumby.init.js"),
                    File.join(javascripts_path, "gumby.init.js.erb")

    gsub_file File.join(javascripts_path, "gumby.init.js.erb"),
              /yep: Gumby\.touchEvents\+'\/jquery.mobile.custom.min.js'/,
              "yep: \"<%= asset_path('jquery.mobile.gumby.min.js') %>\""

    ############################################################################
    # 3: Clean and re-copy the sass / stylesheets folder:
    FileUtils.rm_r  Dir[File.join(stylesheets_path, "*")], force: true
    FileUtils.cp_r  File.join(gumby_source_path, "sass"), stylesheets_path

    # 3.3: Rename the "sass" folder to "gumby":
    FileUtils.move  File.join(stylesheets_path, "sass"),
                    File.join(stylesheets_path, "gumby")

    # 3.4: Rename the "gumby/var" folder to "gumby/defaults":
    FileUtils.move  File.join(stylesheets_path, "gumby", "var"),
                    File.join(stylesheets_path, "gumby", "default")

    # 3.5:
    scss_files_to_remove = %w(gumby.scss _custom.scss).map do |f|
      File.join stylesheets_path, "gumby", f
    end
    FileUtils.rm_r scss_files_to_remove, force: true

    # Replace /url\('?../fonts/(.+)'?\)/i" with 'font-url("$1")'
    # at stylesheets/_fonts.scss:
    gsub_file File.join(stylesheets_path, "gumby", "_fonts.scss"),
              /\surl\(\.\.\/fonts\/(\S+)\)/ ,
              ' font-url("\1")'
    gsub_file File.join(stylesheets_path, "gumby", "_fonts.scss"),
              /\surl\('\.\.\/fonts\/(\S+)'\)/ ,
              ' font-url("\1")'

    ############################################################################
    # 4: Copy demo assets to dummy:
    dummy_images_path = File.join(File.dirname(__FILE__), "test/dummy/app/assets/images")
    FileUtils.rm_r  Dir[File.join(dummy_images_path, "*")], force: true
    FileUtils.cp_r  Dir[File.join(gumby_source_path, "img", "*")], dummy_images_path

  end
end
