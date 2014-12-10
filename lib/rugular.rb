Dir["#{__dir__}/**/*.rb"].each { |f| require f }

module Rugular
  class Rugular < Thor

    register(New, 'new', 'new', 'create a new Rugular project')

    register(
      Dependencies,
      'dependencies',
      'dependencies',
      'install project dependencies'
    )

    register(
      Server,
      'server',
      'server',
      'start the Rugular server'
    )

    register(
      Build,
      'build',
      'build',
      'build the Rugular distribution'
    )

    register(
      Generate,
      'generate',
      'generate',
      'generate an angular service'
    )
  end
end
