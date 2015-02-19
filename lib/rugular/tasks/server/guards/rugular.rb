require 'guard'
require_relative 'rugular_haml'
require_relative 'rugular_coffee'
require_relative 'rugular_vendor_and_bower_components'
require_relative 'rugular_index_html'
require_relative 'rugular_assets'

module Guard
  class Rugular < Plugin

    def initialize(opts = {})
      super(opts)
    end

    def start
      run_all
    end

    def stop; true end
    def reload; true end

    def run_all
      run_on_changes(
        Dir.glob('src/**/*').unshift('vendor_and_bower_components.yaml')
      )
    end

    def run_on_changes(paths)
      [*paths].each do |file|
        message = case File.extname(file)
                  when '.coffee' then ::RugularCoffee.compile(file)
                  when '.haml'   then ::RugularHaml.compile(file)
                  when '.yaml'   then ::RugularVendorAndBowerComponents.compile
                  when '.png'    then ::RugularAssets.copy_asset(file)
                  when '.jpg'    then ::RugularAssets.copy_asset(file)
                  when '.ttf'    then ::RugularAssets.copy_asset(file)
                  when '.woff'   then ::RugularAssets.copy_asset(file)
                  else next 'Rugular does not know how to handle this file'
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

        message = case File.extname(file)
                  when '.coffee' then ::RugularCoffee.delete(file)
                  when '.haml'   then ::RugularHaml.delete(file)
                  when '.png'    then ::RugularAssets.delete_asset(file)
                  when '.jpg'    then ::RugularAssets.delete_asset(file)
                  when '.ttf'    then ::RugularAssets.delete_asset(file)
                  when '.woff'   then ::RugularAssets.delete_asset(file)
                  when '.yaml'
                    then fail 'what are you doing? trying to break rugular?!'
                  else next 'Rugular does not know how to handle this file'
                  end

        ::RugularIndexHtml.update_javascript_script_tags

        ::Guard::UI.info message
      end
    rescue StandardError => error
      handle_error_in_guard(error)
    end

    private

    def handle_error_in_guard(error)
      ::Guard::UI.error error.message
      throw :task_has_failed
    end
  end
end

