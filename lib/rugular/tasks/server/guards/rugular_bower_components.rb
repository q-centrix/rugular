require 'uglifier'
require 'coffee_script'

class RugularBowerComponents
  def self.compile
    new.compile
  end

  def initialize; end

  def compile
    ::Guard::UI.info 'Beginning to create a manifest bower files'

    File.open('.tmp/vendor.css', 'w') do |file|
      file.write bower_css
    end
    File.open('.tmp/vendor.js', 'w') do |file|
      file.write bower_javascript
    end

    'Successfully created manifest bower files'
  end

  private

  def bower_css
    bower_yaml.fetch('css').reduce('', &read_bower_component_files)
  end

  def bower_javascript
    Uglifier.compile(
      bower_yaml.fetch('js').reduce('', &read_bower_component_files)
    )
  end

  def bower_yaml
    YAML.load(File.read('bower_components.yaml'))
  end

  def read_bower_component_files
    lambda do |accumulator, filename|
      bower_component_file = 'bower_components/' + filename

      fail "#{filename} does not exist" unless File.file? bower_component_file

      accumulator += File.read bower_component_file
    end
  end
end
