Dir.glob("#{__dir__}/helpers/**/*.rb").each {|file| require file}

require 'open3'

module Rugular
  class Server < Thor::Group
    include Thor::Actions

    Rugular::AppChecker.check_rugular!(self_task, new.destination_root)

    desc 'runs the test suite and a dev server on localhost:8080'

    def start_server
      Open3.popen2e(
        "bundle exec foreman start --color --root=#{destination_root}" \
        "--procfile=#{rugular_procfile}"
      ) do |stdin, stdout_and_stderr, wait_thr|
        stdout_and_stderr.each_line { |line| puts line }
      end
    end

    private

    def rugular_procfile
      "#{__dir__}/server/Procfile"
    end
  end
end
