require 'ostruct'

module Rugular
  class GeneratorBase < Thor::Group
    include Thor::Actions

    argument :name, desc: 'Name for your route'

    # specify a component
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

    def inject_module_into_app_module
      insert_into_file(
        app_module_file,
        module_declaration,
        after: "angular.module 'app', [\n"
      ) unless module_declaration_present?
    end

    def template_files; []; end

    protected

    def folder
      options[:c] ? "src/components/#{name}" : "src/app/#{name}"
    end

    def route_pathnames
      Dir.glob(template_files).map do |file_name|
        Pathname.new(file_name)
      end
    end

    def destination_file(pathname)
      "#{folder}/#{pathname.basename('.erb').to_s.gsub('app', name)}"
    end

    def open_struct
      @_open_struct ||= OpenStruct.new(name: name)
    end

    def lib_directory
      __dir__.chomp('/tasks/generate')
    end

    def app_module_file
      'src/app/app.module.coffee'
    end

    def module_declaration
      "  '#{name}'\n"
    end

    def module_declaration_present?
      File.read(app_module_file).include? module_declaration
    end

  end
end
