module Rugular
  class JavascriptFiles
    def self.ordered_array
      Dir.glob('src/components/**/*.module.coffee') +
        Dir.glob('src/components/**/*.constant.coffee') +
        Dir.glob('src/components/**/*.factory.coffee') +
        Dir.glob('src/components/**/*.filter.coffee') +
        Dir.glob('src/components/**/*.controller.coffee') +
        Dir.glob('src/components/**/*.directive.coffee') +
        Dir.glob('src/app/**/*.module.coffee') +
        Dir.glob('src/app/**/*.config.coffee')
        Dir.glob('src/app/**/*.constant.coffee') +
        Dir.glob('src/app/**/*.controller.coffee') +
        Dir.glob('src/app/**/*.routes.coffee')
    end
  end
end
