require 'coffee-script'
require 'sass'

module Rugular
  class ContinuousIntegration < Thor::Group
    include Thor::Actions

    def self.exit_on_failure?
      true
    end

    desc('runs the tests once for continuous integration')

    def run_karma_script
      system(
        "./node_modules/karma/bin/karma start "\
        "--single-run --no-auto-watch karma.conf.js"
      )
    end

    private
    # TODO: this requires a selenium driver, such as sauce labs.
    # http://stackoverflow.com/questions/23150585/getting-started-with-protractor-travis-and-saucelabs
    # def run_protractor_script
    #   system(
    #     "npm install -g protractor mocha coffee-script; "\
    #     "webdriver-manager update --standalone; "\
    #     "webdriver-manager start  > /dev/null 2>&1 &; "\
    #     "protractor"
    #   )
    #
    #   return false unless $?.exitstatus == 0
    # end
  end
end
