module Rugular
  class Abstract < Thor::Group
    include Thor::Actions

    argument :folder, desc: 'Component folder you want to abstract'
    desc <<-DESC
      The abstract command copies the contents of any folder nested one-level
      beneath ``src/components`` into the ``~/bower_components`` folder where
      it is treated like a bower component.

      The command will ask some setup questions to generate a bower.json. It is
      recommended that the bower component folders generated by rugular are NOT
      edited by hand. Instead, the only updates should occur by repeated use of
      the ``rugular abstract`` command.
    DESC

    def check_for_rugular_directory
      ::Rugular::AppChecker.check_for_rugular_directory(
        task_name: self.class.name,
        root_directory: destination_root
      )
    end

    def initialize_or_create_version

    end

    def file_copy_folder_into_bower_src_folder
      directory component_directory, bower_component_directory
    end

    def create_bower_file
      return if bower_component_bower_json?

      create_file "#{bower_component_directory}/bower.json" do
        ERB.new(bower_template_file).result(
          bower_open_struct.instance_eval { binding }
        )
      end
    end

    private

    def bower_component_bower_json?
      File.exists? bower_component_directory
    end

    def bower_component_bower_json
      JSON.parse(File.read("#{bower_component_directory}/bower.json"))
    end

    def previous_version
      return 'not defined' unless bower_component_bower_json?

      bower_component_bower_json.fetch('version', '0.0.0')
    end

    def bower_json
      JSON.parse(File.read('bower.json'))
    end

    def git_username
      "#{`git config user.name`.strip} <#{`git config user.email`.strip}>"
    end

    def bower_component_directory
      "#{Dir.home}/bower_components/#{folder}"
    end

    def component_directory
      "./src/components/#{folder}/"
    end

    def main_javascript_files
      Dir.glob("#{component_directory}/*").map do |filename|
        File.basename(filename)
      end
    end

    def bower_open_struct
      OpenStruct.new(
        name: folder,
        version: @version,
        git_username: git_username,
        description: folder,
        main_javascript_files: main_javascript_files,
        dev_dependencies: bower_json.fetch('devDependencies', {}),
        dependencies: bower_json.fetch('dependencies', {}),
        resolutions: bower_json.fetch('resolutions', {})
      )
    end

    def bower_template_file
      lib_directory = __dir__.chomp('/tasks')

      File.read("#{lib_directory}/templates/abstract/bower.json")
    end
  end
end
