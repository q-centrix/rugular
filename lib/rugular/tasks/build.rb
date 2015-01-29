Dir.glob("#{__dir__}/helpers/**/*.rb").each {|file| require file}
require 'uglifier'
require 'coffee_script'
require 'sass'
require 'haml'

module Rugular
  class Build < Thor::Group
    include Thor::Actions

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
      File.open('dist/bower_components.js', 'w') do |file|
        file.write(Uglifier.compile(bower_javascript))
      end
    end

    def compile_bower_stylesheets
      File.open('dist/bower_components.css', 'w') do |file|
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
        html = haml_html.tr("\n", '').gsub("'", "\'")
        html_filename = haml_file.gsub('src/', '').gsub('haml', 'html')
        IO.write('dist/application.js', File.open('dist/application.js') do |f|
          f.read.gsub(html_filename, html)
        end)
      end
    end

    def create_application_css_file
      `sass src/application.sass dist/application.css`
    end

    private

    def javascript_files
      Dir.glob("vendor/**/*.coffee") +
        Dir.glob("src/**/*.module.coffee").sort(&reverse_nested) +
        Dir.glob("src/**/*.routes.coffee").sort(&reverse_nested) +
        Dir.glob("src/**/*.factory.coffee").sort(&reverse_nested) +
        Dir.glob("src/**/*.controller.coffee").sort(&reverse_nested) +
        Dir.glob("src/**/*.directive.coffee").sort(&reverse_nested)
    end

    def reverse_nested
      lambda do |x, y|
        x.scan('/').length <=> y.scan('/').length
      end
    end

    def bower_css
      bower_yaml.fetch('css').map do |filename|
        File.read('bower_components/' + filename)
      end.join
    end

    def bower_javascript
      bower_yaml.fetch('js').map do |filename|
        File.read('bower_components/' + filename)
      end.join
    end

    def bower_yaml
      YAML.load(File.read('src/bower_components.yaml'))
    end
  end
end
