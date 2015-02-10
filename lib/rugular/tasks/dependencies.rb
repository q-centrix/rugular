Dir.glob("#{__dir__}/helpers/**/*.rb").each {|file| require file}

module Rugular
  class Dependencies < Thor::Group
    include Thor::Actions

    desc('Installs dependencies (bundle, bower and npm)')

    def self.exit_on_failue?; true end
    def check_for_rugular_directory
      ::Rugular::AppChecker.check_for_rugular_directory(
        task_name: self.class.name,
        root_directory: destination_root
      )
    end

    def bundle
      puts 'Installing Ruby gems'
      system('bundle install')
    end

    def bower
      puts 'Installing bower packages'
      system('bower install')
    end

    def npm_install
      puts 'Installing node packages'
      system('npm install')
    end

    # Protractor needs to be installed globally
    def install_protractor
      `npm install -g protractor coffee-script mocha`
    end
  end
end
