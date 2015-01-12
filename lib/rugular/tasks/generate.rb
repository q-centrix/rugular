Dir.glob("#{__dir__}/{helpers,generate}/**/*.rb").each {|file| require file}

module Rugular
  class Generate < Thor
    include Thor::Actions

    Rugular::AppChecker.check_rugular!(self.name, new.destination_root)

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

  end
end
