Dir.glob("#{__dir__}/helpers/**/*.rb").each {|file| require file}
require 'uglifier'
require 'coffee_script'
require 'sass'
require 'haml'

module Rugular
  class Build < Thor::Group
    include Thor::Actions

    # This is a really long comment This is a really long comment This is a really long comment This is a really long comment This is a really long comment This is a really long comment
    desc('Creates a minified, compressed version in the dist folder')

    Rugular::AppChecker.check_rugular!(self.name, new.destination_root)

    def create_dist_folder
      FileUtils.mkdir_p('./dist') unless File.directory? './dist'
    end

    def write_dist_index_html_file
      File.open('dist/index.html', 'w') do |file|
        file.write ::Haml::Engine.new(File.read('src/index.haml')).render
      end
    end

    def compile_bower_javascript
      File.open('dist/vendor.js', 'w') do |file|
        file.write(Uglifier.compile(bower_and_vendor_javascript))
      end
    end

    def compile_bower_stylesheets
      File.open('dist/vendor.css', 'w') do |file|
        file.write bower_css
      end
    end

    def create_application_js_file
      File.open('dist/application.js', 'w') do |file|
        file.write(
          Uglifier.compile(
            javascript_files.map do |file|
              text = File.read(file).gsub('templateUrl', 'template')
              CoffeeScript.compile(text)
            end.join
          )
        )
      end
    end

    def inline_template_url_files
      (Dir.glob("**/*.haml") - ["src/index.haml"]).each do |haml_file|
        haml_html = ::Haml::Engine.new(File.read(haml_file), {}).render
        html = haml_html.tr("\n", '').gsub("'", "\'").gsub('"', '\"')
        html_filename = haml_file.gsub('src/', '').gsub('haml', 'html')
        IO.write('dist/application.js', File.open('dist/application.js') do |f|
          f.read.gsub(html_filename, html)
        end)
      end
    end

    def add_template_application_sass_file
      FileUtils.cp(
        "#{lib_directory}/templates/server/application.sass",
        "#{destination_root}/.application.sass"
      )
    end

    def create_application_css_file
      `sass .application.sass dist/application.css -r sass-globbing`
    end

    def copy_images
      FileUtils.cp_r('src/images', 'dist')
    end

    def copy_fonts
      FileUtils.cp_r('src/fonts', 'dist')
    end

    private

    def bower_and_vendor_javascript
      bower_javascript + vendor_javascript
    end

    def bower_javascript
      bower_yaml.fetch('bower_components').fetch('js').map do |filename|
        File.read('bower_components/' + filename)
      end.join
    end

    def vendor_javascript
      bower_yaml.fetch('vendor').fetch('coffee').map do |filename|
        CoffeeScript.compile(File.read('vendor/' + filename))
      end.join
    end

    def javascript_files
      Dir.glob("src/components/**/*.module.coffee") +
        Dir.glob("src/components/**/*.factory.coffee") +
        Dir.glob("src/components/**/*.filter.coffee") +
        Dir.glob("src/components/**/*.controller.coffee") +
        Dir.glob("src/components/**/*.directive.coffee") +
        Dir.glob("src/components/**/*.routes.coffee") +
        Dir.glob("src/app/**/*.module.coffee") +
        Dir.glob("src/app/**/*.factory.coffee") +
        Dir.glob("src/app/**/*.filter.coffee") +
        Dir.glob("src/app/**/*.controller.coffee") +
        Dir.glob("src/app/**/*.directive.coffee") +
        Dir.glob("src/app/**/*.routes.coffee")
    end

    def bower_css
      bower_yaml.fetch('bower_components').fetch('css').map do |filename|
        File.read('bower_components/' + filename)
      end.join
    end


    def bower_yaml
      YAML.load(File.read('src/vendor_and_bower_components.yaml'))
    end

    def lib_directory
      __dir__.chomp('tasks')
    end
  end
end
