require 'guard'
require_relative 'rugular_haml'
require_relative 'rugular_coffee'
require_relative 'rugular_vendor_and_bower_components'
require_relative 'rugular_index_html'

module Guard
  class Rugular < Plugin

    def initialize(opts = {})
      super(opts)
    end

    def start; true end
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
        when 'yaml'   then message = ::RugularVendorAndBowerComponents.compile
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

        case file.split('.').last
        when 'haml'   then message = ::RugularHaml.delete(file)
        when 'coffee' then message = ::RugularCoffee.delete(file)
        when 'yaml'   then fail 'what are you doing? trying to break rugular?!'
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

