Dir.glob("#{__dir__}/helpers/**/*.rb").each { |file| require file }
require 'uglifier'
require 'coffee_script'
require 'sass'
require 'haml'

module Rugular
  class Abstract < Thor::Group
    include Thor::Actions

    class_option(
      :c,
      type: :boolean,
      desc: 'Create a component with just the component folder'
    )

    desc <<-DESC
      Creates a release manifest javascript file to be used as a bower
      component
    DESC

    def check_for_rugular_directory
      ::Rugular::AppChecker.check_for_rugular_directory(
        task_name: self.class.name,
        root_directory: destination_root
      )
    end

    def bower_json
      @_json ||= JSON.parse(File.read('bower.json')).to_h
    end

    def increment_bower_version_if_file_exists
      return unless File.exists? "release/#{app_name}.js"

      new_bower_json = bower_json.tap do |json|
        json['version'] = next_version
      end

      File.open('bower.json', 'w') do |file|
        file.write new_bower_json
      end
    end

    def write_release_js_files
      File.open(release_js, 'w') do |file|
        file.write(
          javascript_files.map do |javascript_file|
            CoffeeScript.compile(
              File.read(javascript_file).gsub('templateUrl', 'template')
            )
          end.join
        )
      end

      File.open(release_min_js, 'w') do |file|
        file.write(
          Uglifier.compile(

            javascript_files.map do |javascript_file|
              CoffeeScript.compile(
                File.read(javascript_file).gsub('templateUrl', 'template')
              )
            end.join

          )
        )
      end
    end

    def inline_template_url_files
      (Dir.glob('**/*.haml') - ['src/index.haml']).each do |haml_file|
        haml_html = ::Haml::Engine.new(File.read(haml_file), {}).render

        html = haml_html.tr("\n", '').gsub("'", "\'").gsub('"', '\"')

        html_filename = haml_file.gsub('src/', '').gsub('haml', 'html')

        IO.write(release_js, File.open(release_js) do |f|
          f.read.gsub(html_filename, html)
        end)

        IO.write(release_min_js, File.open(release_js) do |f|
          f.read.gsub(html_filename, html)
        end)
      end
    end

    def write_application_css_file
      `sass .application.sass release/#{app_name}.css -r sass-globbing`
    end

    private

    def app_name
      destination_root.split('/').last
    end

    def previous_version
      bower_json.fetch('version')
    end

    def next_version
      next_patch = previous_version.split('.').last.to_i + 1

      (previous_version.split('.')[0..-2] << next_patch).join('.')
    end

    def javascript_files
      if options[:c]
        ::Rugular::JavascriptFiles.component_array
      else
        ::Rugular::JavascriptFiles.ordered_array
      end
    end

    def release_js
      "release/#{app_name}.js"
    end

    def release_min_js
      "release/#{app_name}.js"
    end
  end
end
