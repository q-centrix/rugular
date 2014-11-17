Dir["#{__dir__}/**/*.rb"].each { |f| require f }

module Rugular
  class Rugular < Thor

    register(New, 'new', 'new', 'Create a new Rugular project')

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
