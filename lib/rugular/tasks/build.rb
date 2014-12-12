Dir.glob("#{__dir__}/helpers/**/*.rb").each {|file| require file}

module Rugular
  class Build < Thor::Group
    include Thor::Actions

    desc('Creates a minified, compressed version in the dist folder')

    Rugular::AppChecker.check_rugular!(self.name, new.destination_root)

    # TODO: build from the ./.tmp folder
    def compile_coffeescript
      puts CoffeeScript.compile File.read("app.coffee")
    end

    def uglify_css
      puts Uglifier.compile(CoffeeScript.compile File.read("app.coffee"))
    end

    def interpret_sass
      template = File.load('stylesheets/sassy.sass')
      sass_engine = Sass::Engine.new(template)
      output = sass_engine.render
      puts output
    end
  end
end
