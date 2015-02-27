require 'guard'
require_relative 'rugular_assets'
require_relative 'rugular_bower_components'
require_relative 'rugular_coffee'
require_relative 'rugular_es6'
require_relative 'rugular_haml'
require_relative 'rugular_index_html'

module Guard
  class Rugular < Plugin

    def initialize(opts = {})
      super(opts)
    end

    def start
      create_tmp_directory

      run_on_changes('src/index.haml')

      run_all
    end

    def stop; true end
    def reload; true end

    def run_all
      run_on_changes(Dir.glob('src/**/*').push('bower_components.yaml'))
    end

    def run_on_changes(paths)
      [*paths].each do |file|
        message =
          case File.extname(file)
          when '.es6'    then ::RugularES6.compile(file)
          when '.coffee' then ::RugularCoffee.compile(file)
          when '.haml'   then ::RugularHaml.compile(file)
          when '.yaml'   then ::RugularBowerComponents.compile
          when '.png'    then ::RugularAssets.copy_asset(file)
          when '.jpg'    then ::RugularAssets.copy_asset(file)
          when '.ttf'    then ::RugularAssets.copy_asset(file)
          when '.woff'   then ::RugularAssets.copy_asset(file)
          else "Rugular does not know how to handle #{file}"
          end

        ::RugularIndexHtml.update_javascript_script_tags

        ::Guard::UI.info message
      end
    rescue StandardError => error
      handle_error_in_guard(error)
    end

    def run_on_removals(paths)
      [*paths].each do |file|
        ::Guard::UI.info "Guard received delete event for #{file}"

        message =
          case File.extname(file)
          when '.es6'    then ::RugularES6.delete(file)
          when '.coffee' then ::RugularCoffee.delete(file)
          when '.haml'   then ::RugularHaml.delete(file)
          when '.yaml'   then fail "Please restore #{file}"
          when '.png'    then ::RugularAssets.delete_asset(file)
          when '.jpg'    then ::RugularAssets.delete_asset(file)
          when '.ttf'    then ::RugularAssets.delete_asset(file)
          when '.woff'   then ::RugularAssets.delete_asset(file)
          else "Rugular does not know how to handle #{file}"
          end

        ::RugularIndexHtml.update_javascript_script_tags

        ::Guard::UI.info message
      end
    rescue StandardError => error
      handle_error_in_guard(error)
    end

    private

    def create_tmp_directory
      FileUtils.mkdir '.tmp' unless File.directory? '.tmp'
    end

    def handle_error_in_guard(error)
      ::Guard::UI.error error.message
      throw :task_has_failed
    end
  end
end
