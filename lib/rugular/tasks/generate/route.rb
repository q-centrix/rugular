require_relative 'generator_base'

module Rugular
  class Route < GeneratorBase

    def template_files
      Dir.glob("#{lib_directory}/templates/route/*.erb")
    end

    def app_or_component
      'app'
    end
  end
end
