Dir["#{__dir__}/**/*.rb"].each { |f| require f }

module Rugular
  class Rugular < Thor

    register(New, 'new', 'new', 'create a new Rugular project')

    register(
      Build,
      'build',
      'build',
      'build the Rugular distribution'
    )

    register(
      ContinuousIntegration,
      'ci',
      'ci',
      'run the Rugular tests once for CI'
    )

    register(
      Dependencies,
      'dependencies',
      'dependencies',
      'install project dependencies'
    )

    register(
      Generate,
      'generate',
      'generate',
      'generate an angular service'
    )

    register(
      Server,
      'server',
      'server',
      'start the Rugular server'
    )

    register(
      Tmux,
      'tmux',
      'tmux',
      'start a rugular tmux session'
    )

    register(
      Abstract,
      'abstract',
      'abstract',
      'abstract a bower component to the "~/bower_components" directory'
    )
  end
end
