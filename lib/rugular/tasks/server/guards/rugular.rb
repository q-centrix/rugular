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
      run_on_changes(Dir.glob('**/*'))
    end

    def run_on_changes(paths)
      paths.each do |file|
        case file.split('.').last
        when 'haml'   then message = compile_haml(file)
        when 'coffee' then message = compile_coffee(file)
        when 'sass'   then message = compile_sass(file)
        end
        ::Guard::UI.info message
      end
    end

    def run_on_removals(paths)
      run_on_changes(paths)
    end

    private

    def compile_haml(file)
      html = ::Haml::Engine.new(File.read(file), {}).render

      if file == 'index.html'
        File.open('dist/index.html', 'w') do |file|
          file.write = html
        end
      else
        compile_coffee('app/app.coffee')

        IO.write('dist/application.js', File.open('dist/application.js') do |f|
          f.read.gsub(%r{#{file}}, html).gsub('templateURL', 'template')
        end)
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
            bower_javascript +
            CoffeeScript.compile(
              javascript_files.map { |e| File.read(e) }.join
            ),
            comments: false
          )
        )
      end

      message = "Successfully compiled #{file} to js!\n"
    rescue StandardError => error
      handle_error_in_guard(error)
    end

    def compile_sass(file)
      Sass::Engine.new(File.read(file)).to_css

      File.open("dist/application.css", 'w') do |file|
        file.write(
          bower_css +
          Sass::Engine.new(
            Dir.glob("**/*.sass").sort.map { |e| File.read(e) }.join,
            syntax: :sass,
            debug_info: true,
            template_location: 'src'
          ).render
        )
      end

      message = "Successfully compiled #{file} to css!\n"
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
      YAML.load(File.read('src/bower_components.yml'))
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

  end
end

