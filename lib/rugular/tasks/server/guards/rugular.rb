require 'guard/compat/plugin'
require 'haml'
require 'sass'
require 'coffee_script'
require 'uglifier'

module Guard
  class Rugular < Plugin

    def initialize(opts = {})
      super(opts)
    end

    def start; true end
    def stop; true end
    def reload; true end

    def run_all
      run_on_changes('src/app/app.coffee')
    end

    def run_on_changes(paths)
      paths.each do |file|
        ::Guard::UI.info "Guard received save event for #{file}"

        case file.split('.').last
        when 'haml'   then message = compile_haml(file)
        when 'coffee' then message = compile_coffee(file)
        when 'sass'   then message = compile_sass(file)
        when 'yaml'   then message = compile_yaml
        end

        ::Guard::UI.info message
      end
    end

    def run_on_removals(paths)
      run_on_changes(paths)
    end

    private

    def compile_haml(file)
      html = ::Haml::Engine.new(File.read(file)).render

      if file == 'src/index.html'
        File.open('dist/index.html', 'w') do |file|
          file.write = html
        end
      else
        compile_coffee('src/app/app.module.coffee')
      end

      message = "Successfully compiled #{file} to html!\n"
    rescue StandardError => error
      handle_error_in_guard(error)
    end

    def compile_coffee(file)
      CoffeeScript.compile(file)

      File.open('dist/application.js', 'w') do |file|
        file.write(
          Uglifier.compile(
            CoffeeScript.compile(
              javascript_files.map { |e| File.read(e) }.join,
            ).gsub('templateUrl', 'template'),
            comments: false
          )
        )
      end

      # Inline templates into javascript
      (Dir.glob("**/*.haml") - ["src/index.haml"]).each do |haml_file|
        html = ::Haml::Engine.new(File.read(haml_file), {}).render
        haml_file.gsub!('src/', '').gsub!('haml', 'html')
        IO.write('dist/application.js', File.open('dist/application.js') do |f|
          f.read.gsub(haml_file, html)
        end)
      end

      message = "Successfully compiled #{file} to js!\n"
    rescue StandardError => error
      handle_error_in_guard(error)
    end

    def compile_sass(file)
      sass_engine.for_file(File.read(file)).to_css

      File.open("dist/application.css", 'w') do |file|
        file.write(
          Dir.glob("**/*").reject(&partial_sass_files).map(&read_file).map do |file|
            Sass::Engine.for_file(
              file,
              syntax: :sass,
              template_location: 'src'
            )
          end.join
        )
      end

      message = "Successfully compiled #{file} to css!\n"
    rescue StandardError => error
      handle_error_in_guard(error)
    end

    def partial_sass_files
      lambda { |filename| filename =~ /^_/ }
    end

    def read_file
      lambda { |filename| File.read(filename) }
    end

    def compile_yaml
      File.open("dist/bower_components.css", 'w') do |file|
        file.write bower_css
      end
      File.open("dist/bower_components.js", 'w') do |file|
        file.write Uglifier.compile(bower_javascript)
      end

      message = 'Successfully created bower_component dist files'
    rescue StandardError => error
      handle_error_in_guard(error)
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

    def handle_error_in_guard(error)
      message = "#{error.message}"
      ::Guard::UI.error message
      throw :task_has_failed
    end

    def javascript_files
      Dir.glob("**/*.module.coffee").sort(&reverse_nested) +
        Dir.glob("**/*.routes.coffee").sort(&reverse_nested) +
        Dir.glob("**/*.factory.coffee").sort(&reverse_nested) +
        Dir.glob("**/*.controller.coffee").sort(&reverse_nested) +
        Dir.glob("**/*.directive.coffee").sort(&reverse_nested)
    end

    def reverse_nested
      lambda do |x, y|
        x.scan('/').length <=> y.scan('/').length
      end
    end

    def sass_engine
      @_sass_engine ||= Sass::Engine
    end

  end
end

