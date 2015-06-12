Dir.glob("#{__dir__}/helpers/**/*.rb").each {|file| require file}
require 'uglifier'
require 'coffee_script'
require 'sass'
require 'haml'

module Rugular
  class Build < Thor::Group
    include Thor::Actions

    desc('Creates a minified, compressed version in the dist folder')

    def check_for_rugular_directory
      ::Rugular::AppChecker.check_for_rugular_directory(
        task_name: self.class.name,
        root_directory: destination_root
      )
    end

    def write_dist_index_html_file
      File.open('dist/index.html', 'w') do |file|
        file.write ::Haml::Engine.new(File.read('src/index.haml')).render
      end
    end

    def compile_bower_javascript
      File.open('dist/vendor.js', 'w') do |file|
        file.write(Uglifier.compile(bower_javascript))
      end
    end

    def create_application_js_file
      File.open('dist/application.js', 'w') do |file|
        file.write(
          Uglifier.compile(

            ::Rugular::JavascriptFiles.ordered_array.map do |javascript_file|
              text = File.read(javascript_file).gsub('templateUrl', 'template')

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

    def copy_images
      FileUtils.cp_r('src/images', 'dist')
    end

    def copy_fonts
      FileUtils.cp_r('src/fonts', 'dist')
    end

    private

    def bower_javascript
      bower_yaml.fetch('js').map do |filename|
        File.read('bower_components/' + filename)
      end.join
    end

    def bower_yaml
      YAML.load(File.read('bower_components.yaml'))
    end

    def lib_directory
      __dir__.chomp('tasks')
    end
  end
end
