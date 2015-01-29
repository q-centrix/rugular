require 'uglifier'

class RugularBowerComponents
  def self.compile
    new.compile
  end

  def initialize; end

  def compile
    File.open('.tmp/bower_components.css', 'w') do |file|
      file.write bower_css
    end
    File.open('.tmp/bower_components.js', 'w') do |file|
      file.write(Uglifier.compile(bower_javascript))
    end

    message = 'Successfully created bower_component dist files'
  rescue StandardError => error
    handle_error_in_guard(error)
  end

  private

  def bower_css
    bower_yaml.fetch('css').map do |filename|
      File.read('bower_components/' + filename)
    end.join
  end

  def bower_javascript
    bower_yaml.fetch('js').map do |filename|
      File.read('bower_components/' + filename)
    end.join
  end

  def bower_yaml
    YAML.load(File.read('src/bower_components.yaml'))
  end
end

