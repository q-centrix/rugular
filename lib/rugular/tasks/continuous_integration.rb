require 'coffee-script'
require 'sass'

module Rugular
  class ContinuousIntegration < Thor::Group
    include Thor::Actions

    desc('runs the tests once for continuous integration')

    def compile_to_tmp_folder(folder: Pathname.new(".tmp"))
      compile_coffescript_files(folder)

      complie_sass_files(folder)

      compile_haml_files(folder)
    end

    def run_karma_script
      system(
        "./node_modules/karma/bin/karma start "\
        "--single-run --no-auto-watch karma.conf.js"
      )

      return false unless $?.exitstatus == 0
    end

    def completed_tests
      puts "Your tests have passed!!"
    end

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

    private

    def compile_coffescript_files(folder)
      src_coffeescript_files.each do |file|
        create_file file.to_s.gsub('./src/', './.tmp/').gsub('coffee', 'js') do
          CoffeeScript.compile(file)
        end
      end
    end

    def compile_haml_files(folder)
      src_haml_files.each do |file|
        create_file file.to_s.gsub('./src/', './.tmp/').gsub('haml', 'html') do
          HamlRenderer.render(file)
        end
      end
    end

    def complie_sass_files(folder)
      src_sass_files.each do |file|
        create_file file.to_s.gsub('./src/', './.tmp/').gsub('sass', 'css') do
          Sass::Engine.new(file.read, load_paths: ["./."]).to_css
        end
      end
    end

    def src_coffeescript_files
      Dir.glob("./src/**/*.coffee").map(&transform_to_pathname)
    end

    def src_haml_files
      Dir.glob("./src/**/*.haml").map(&transform_to_pathname)
    end

    def src_sass_files
      Dir.glob("./src/**/*.sass").map(&transform_to_pathname)
    end

    def transform_to_pathname
      ->(file_name) { Pathname.new(file_name) }
    end

  end
end
