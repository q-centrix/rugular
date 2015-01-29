require 'guard'
require_relative 'rugular_haml'
require_relative 'rugular_coffee'

module Guard
  class Rugular < Plugin

    def initialize(opts = {})
      super(opts)
    end

    def start; run_all end
    def stop; true end
    def reload; true end

    def run_all
      run_on_changes(Dir.glob("src/**/*"))
    end

    def run_on_changes(paths)
      [*paths].each do |file|
        ::Guard::UI.info "Guard received save event for #{file}"

        case file.split('.').last
        when 'haml'   then message = ::RugularHaml.compile(file)
        when 'coffee' then message = ::RugularCoffee.compile(file)
        when 'yaml'   then message = compile_yaml
        end

        ::Guard::UI.info message
      end
    rescue StandardError => error
      handle_error_in_guard(error)
    end

    def run_on_removals(paths)
      [*paths].each do |file|
        ::Guard::UI.info "Guard received delete event for #{file}"

        case file.split('.').last
        when 'haml'   then message = ::RugularHaml.delete(file)
        when 'coffee' then message = ::RugularCoffee.delete(file)
        when 'yaml'   then fail 'what are you doing? trying to break rugular?!'
        end

        ::Guard::UI.info message
      end
    rescue StandardError => error
      handle_error_in_guard(error)
    end

    private

    def compile_yaml
      File.open("dist/bower_components.css", 'w') do |file|
        file.write bower_css
      end
      File.open("dist/bower_components.js", 'w') do |file|
        file.write(
          # Uglifier.compile(
            bower_javascript
          # )
        )
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
      ::Guard::UI.error error.message
      throw :task_has_failed
    end
  end
end

