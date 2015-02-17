Dir.glob("#{__dir__}/{helpers,generate}/**/*.rb").each {|file| require file}

module Rugular
  class Generate < Thor
    include Thor::Actions

    def self.exit_on_failue?; true end
    def check_for_rugular_directory
      ::Rugular::AppChecker.check_for_rugular_directory(
        task_name: self.class.name,
        root_directory: destination_root
      )
    end

    desc(
      'generate <angular_service> <name>',
      'generates an angular service'
    )
    long_desc <<-LONGDESC
      The generate command creates a new angular service in either the app
      folder (default) or the components folder with the `-c` option.

      The angular services this command can create include:

      * A route (includes a route, controller, controller_spec and view)
      * A factory
      * A directive (includes a view)

      The name that is passed in is the name of the angular service. The
      command will also create an angular module if one does not already exist.
    LONGDESC

    register(
      Rugular::Route,
      'route',
      'route',
      'build an angular route'
    )

    register(
      Rugular::Directive,
      'directive',
      'directive',
      'build an angular directive'
    )

    register(
      Rugular::Filter,
      'filter',
      'filter',
      'build an angular filter'
    )

    register(
      Rugular::Factory,
      'factory',
      'factory',
      'build an angular factory'
    )
  end
end
