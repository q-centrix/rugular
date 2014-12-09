Dir.glob("#{__dir__}/helpers/**/*.rb").each {|file| require file}

module Rugular
  class Generate < Thor::Group
    include Thor::Actions

    Rugular::AppChecker.check_rugular!(self_task, new.destination_root)

    argument :service, :desc => 'Angular service to generate'
    desc "Prints the 'number' given upto 'number+2'"

    # self.destination_root == directory where thor is invoked

    def generate_service
      case service
      when 'controller' then generate_controller

      end
    end

    private

  end
end
