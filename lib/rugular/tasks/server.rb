Dir.glob("#{__dir__}/helpers/**/*.rb").each {|file| require file}
require 'open3'

module Rugular
  class Server < Thor::Group
    include Thor::Actions

    Rugular::AppChecker.check_rugular!(self.name, new.destination_root)

    desc(
      "runs the test suite and a dev server on localhost:8080 "\
      "(set in lib/rugular/tasks/server/Procfile)"
    )

    def add_template_application_sass_file
      FileUtils.cp(
        "#{lib_directory}/templates/server/application.sass",
        "#{destination_root}/.application.sass"
      )
    end

    def start_server
      system(
        "bundle exec foreman start --color --root=#{destination_root} " \
        "--procfile=#{rugular_procfile}"
      )
    end

    private

    def rugular_procfile
      "#{__dir__}/server/Procfile"
    end

    def lib_directory
      __dir__.chomp('tasks')
    end
  end
end
