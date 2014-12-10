Dir.glob("#{__dir__}/helpers/**/*.rb").each {|file| require file}

module Rugular
  class Dependencies < Thor::Group
    include Thor::Actions

    desc('Installs dependencies (bundle, bower and npm)')

    Rugular::AppChecker.check_rugular!(self.name, new.destination_root)

    def bundle
      `bundle install`
    end

    def bower
      `bower install`
    end

    def npm_install
      `npm install`
    end

    # Protractor needs to be installed globally
    def install_protractor
      `npm install -g protractor coffee-script mocha`
    end
  end
end
