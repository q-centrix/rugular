module Rugular
  class AppChecker
    include Thor::Shell

    def self.check_rugular!(task_name, root_directory)
      new(task_name: task_name, root_directory: root_directory).check_rugular!
    end

    def initialize(task_name:, root_directory:)
      @task_name = task_name
      @root_directory = root_directory
    end

    def check_rugular!
      error(rugular_app_message) unless rugular_app?
    end

    private

    attr_reader :task_name, :root_directory

    def rugular_app_message
      "#{task_name} requires a pre-existing Rugular application"
    end

    def rugular_app?
      [
        'bower.json',
        'package.json',
        'src/index.haml',
        'Gemfile',
        '.tmp'
      ].each do |file_name|
        destination_file_name = root_directory + '/' + file_name

        return false unless File.exists?(destination_file_name)
      end
    end

  end
end
