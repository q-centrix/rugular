require 'ostruct'
require 'active_support'

module Rugular
  class GeneratorBase < Thor::Group
    include Thor::Actions

    argument :name, desc: 'Name for your route'

    class_option(
      :c,
      type: :boolean,
      desc: 'create the route in the component folder'
    )

    def self.source_root
      __dir__.chomp('/tasks/generate')
    end

    def create_route_folders
      route_pathnames.each do |pathname|
        next(
          "#{destination_file(pathname)} already exists"
        ) if File.exists? destination_file(pathname)

        create_file destination_file(pathname) do
          ERB.new(pathname.read).result(
            open_struct.instance_eval { binding }
          )
        end
      end
    end

    def inject_module_into_module
      if nested?
        insert_into_file(
          nested_module_file,
          module_declaration,
          after: "angular.module '#{nested_module_name}', [\n"
        ) unless module_declaration_present?(nested_module_file)
      else
        insert_into_file(
          app_module_file,
          module_declaration,
          after: "angular.module 'app', [\n"
        ) unless module_declaration_present?(app_module_file)
      end
    end

    def add_sass_declaration
      append_to_file(
        'src/application.sass',
        "@import '#{folder.sub('src/', '')}'"
      ) unless sass_declaration_present?(folder)
    end

    def template_files; []; end

    protected

    def lib_directory
      __dir__.chomp('tasks/generate')
    end

    def route_pathnames
      Dir.glob(template_files).map do |filename|
        Pathname.new(filename)
      end
    end

    def folder
      options[:c] ? "src/components/#{name_folder}" : "src/app/#{name_folder}"
    end

    def destination_file(pathname)
      "#{folder}/#{pathname.basename('.erb').to_s.gsub('app', name.split(':').last)}"
    end

    def camelcase_name
      name.split(':').last.camelcase(:lower)
    end

    def open_struct
      @_open_struct ||= OpenStruct.new(name: camelcase_name)
    end

    def app_module_file
      'src/app/app.module.coffee'
    end

    def module_declaration
      "  '#{camelcase_name}'\n"
    end

    def module_declaration_present?(module_file)
      File.read(module_file).include? module_declaration
    end

    def sass_declaration_present?(folder)
      File.read("src/application.sass").include?  "@import #{folder}"
    end

    def nested?
      name.split(':').length > 1
    end

    def name_folder
      name.split(':').join('/')
    end

    def nested_module_name
      name.split(':')[-2]
    end

    def nested_module_file
      "src/#{app_or_component}/#{name.split(':')[0..-2].join('/')}/"\
        "#{nested_module_name}.module.coffee"
    end

    def app_or_component
      options[:c] ? 'components' : 'app'
    end
  end
end
