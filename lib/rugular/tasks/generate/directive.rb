require_relative 'generator_base'

module Rugular
  class Directive < GeneratorBase

    def template_files
      Dir.glob("#{lib_directory}/templates/directive/*.erb")
    end

  end
end
