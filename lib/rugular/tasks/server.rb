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

    argument :port, type: :numeric, desc: 'port number to find the server'

    def start_server
      system(
        "bundle exec foreman start --color --root=#{destination_root} " \
        "--procfile=#{rugular_procfile} --port #{port}"
      )
    end

    private

    def rugular_procfile
      "#{__dir__}/server/Procfile"
    end
  end
end
