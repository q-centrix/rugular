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
      template_file_names.each do |(file_name, template_file_name)|
        create_file "#{app_name}/#{template_file_name.gsub('.erb', '')}" do
          pathname = Pathname.new(file_name)

          ERB.new(pathname.read).result(
            app_open_struct.instance_eval { binding }
          )
        end
      end
    end

    def create_component_directory
      empty_directory "#{app_name}/src/components"
    end

    def create_vendor_directory
      empty_directory "#{app_name}/vendor"
    end

    def install_bourbon
      run "cd #{app_name}/vendor && bourbon install "\
        '&& neat install && bitters install'
    end

    def installation_complete
      puts <<-POST_INSTALL_MESSAGE
♪┏(°.°)┛┗(°.°)┓┗(°.°)┛┏(°.°)┓┏(°.°)┛┗(°.°)┓┗(°.°)┛┏(°.°)┓♪

Thank you for installing Rugular, please finish setting up your
project with: `cd #{app_open_struct.name} && rugular dependencies`

♪┏(°.°)┛┗(°.°)┓┗(°.°)┛┏(°.°)┓┏(°.°)┛┗(°.°)┓┗(°.°)┛┏(°.°)┓♪
      POST_INSTALL_MESSAGE
    end

    private

    def app_open_struct
      @_app_open_struct ||= OpenStruct.new(name: app_name)
    end

    def lib_directory
      __dir__.chomp('/tasks')
    end

    def template_file_names
      real_file_names = Dir.glob(
        "#{lib_directory}/templates/new_erb/**/*.erb"
      )
      abbreviated_file_names = real_file_names.map do |file_name|
        file_name.gsub("#{lib_directory}/templates/new_erb/", '')
      end

      real_file_names.zip(abbreviated_file_names)
    end
  end
end
