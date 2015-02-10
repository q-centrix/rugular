require_relative 'generator_base'

module Rugular
  class Factory < GeneratorBase

    def template_files
      Dir.glob("#{lib_directory}/templates/factory/*.erb")
    end

  end
end
