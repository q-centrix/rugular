require 'ostruct'
require 'pathname'

module Rugular
  class New < Thor::Group
    include Thor::Actions

    argument :app_name, desc: 'Name for your application'
    desc('Creates an initial folder structure for developing apps')

    def self.source_root
      __dir__.chomp('/tasks')
    end

    def create_application_directory
      directory "#{lib_directory}/templates/new/", app_open_struct.name
    end

    def create_custom_files
      Dir.glob("#{lib_directory}/templates/new_erb/*.erb").each do |file_name|
        pathname = Pathname.new(file_name)

        create_file "#{app_name}/#{pathname.basename('.erb').to_s}" do
          ERB.new(pathname.read).result(
            app_open_struct.instance_eval { binding }
          )
        end
      end
    end

    def create_component_directory
      empty_directory "#{app_name}/src/components"
    end

    def installation_complete
      puts "Thank you for installing Rugular, please finish setting up your "\
        "project with: `cd #{app_open_struct.name} && bundle install && "\
        "rugular dependencies`\n"\
        "Please install bourbon and neat by bundle exec bourbon install "\
        "--path src/ and neat with bundle exec neat install --path src/"
    end

    private

    def app_open_struct
      @_app_open_struct ||= OpenStruct.new(name: app_name)
    end

    def lib_directory
      __dir__.chomp('/tasks')
    end

  end
end
