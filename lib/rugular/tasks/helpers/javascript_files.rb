module Rugular
  class JavascriptFiles
    def self.ordered_array
      Dir.glob('src/components/**/*.module.{coffee,es6}') +
        Dir.glob('src/components/**/*.constant.{coffee,es6}') +
        Dir.glob('src/components/**/*.factory.{coffee,es6}') +
        Dir.glob('src/components/**/*.filter.{coffee,es6}') +
        Dir.glob('src/components/**/*.controller.{coffee,es6}') +
        Dir.glob('src/components/**/*.directive.{coffee,es6}') +
        Dir.glob('src/app/**/*.module.{coffee,es6}') +
        Dir.glob('src/app/**/*.config.{coffee,es6}') +
        Dir.glob('src/app/**/*.constant.{coffee,es6}') +
        Dir.glob('src/app/**/*.controller.{coffee,es6}') +
        Dir.glob('src/app/**/*.routes.{coffee,es6}')
    end
  end
end
