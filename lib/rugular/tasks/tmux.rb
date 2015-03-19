module Rugular
  class Tmux < Thor::Group
    include Thor::Actions

    def self.exit_on_failue?; true end
    def check_for_rugular_directory
      ::Rugular::AppChecker.check_for_rugular_directory(
        task_name: self.class.name,
        root_directory: destination_root
      )
    end

    desc 'creates a new tmux session with the processes necessary for rugular'

    def copy_tmux_file
      unless File.directory? "#{Dir.home}/.tmuxinator"
        FileUtils.mkdir "#{Dir.home}/.tmuxinator"
      end
      FileUtils.cp tmuxinator_file, "#{Dir.home}/.tmuxinator/rugular.yml"
    end

    def start_tmux
      system 'tmuxinator start rugular'
    end

    private

    def tmuxinator_file
      "#{__dir__}/tmux/tmuxinator.yml"
    end
  end
end
