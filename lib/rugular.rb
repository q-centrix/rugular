Dir["#{__dir__}/**/*.rb"].each { |f| require f }

module Rugular
  class Rugular < Thor

    # Quit task if there is an error
    def self.exit_on_failure?; true; end

    register(New, 'new', 'new', 'Create a new Rugular project')

    register(
      Dependencies,
      'dependencies',
      'generate',
      'Install dependencies (bower, bundle, and npm)'
    )

    register(
      Generate,
      'generate',
      'generate [SCAFFOLD]',
      'Generate a component or feature'
    )

    register(
      Server,
      'server',
      'server',
      'Start the Rugular server and development environment'
    )

    register(
      Build,
      'build',
      'build',
      'Build a production version of your app'
    )

  end
end
