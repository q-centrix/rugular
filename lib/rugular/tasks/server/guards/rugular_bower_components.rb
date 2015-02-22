require 'uglifier'
require 'coffee_script'
require 'uglifier'

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
      file.write(Uglifier.compile(bower_javascript))
    end

    'Successfully created manifest bower files'
  end

  private

  def bower_css
    bower_yaml.fetch('css').map do |filename|
      bower_component_file = 'bower_components/' + filename
      next unless File.file? bower_component_file
      File.read('bower_components/' + filename)
    end.join
  end

  def bower_javascript
    bower_yaml.fetch('js').map do |filename|
      bower_component_file = 'bower_components/' + filename
      next unless File.file? bower_component_file
      File.read('bower_components/' + filename)
    end.join
  end

  def bower_yaml
    YAML.load(File.read('bower_components.yaml'))
  end
end
