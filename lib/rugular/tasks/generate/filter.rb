require_relative 'generator_base'

module Rugular
  class Filter < GeneratorBase

    def template_files
      Dir.glob("#{lib_directory}/templates/filter/*.erb")
    end

  end
end
