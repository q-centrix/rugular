require 'uglifier'
require 'coffee_script'

class RugularVendorAndBowerComponents
  def self.compile
    new.compile
  end

  def initialize; end

  def compile
    ::Guard::UI.info 'Beginning to create vendor asset files'

    File.open('.tmp/vendor.css', 'w') do |file|
      file.write bower_css
    end
    File.open('.tmp/vendor.js', 'w') do |file|
      file.write(Uglifier.compile(bower_and_vendor_javascript))
    end

    'Successfully created vendor asset files'
  end

  private

  def bower_and_vendor_javascript
    bower_javascript + vendor_javascript
  end

  def bower_css
    bower_yaml.fetch('bower_components').fetch('css').map do |filename|
      File.read('bower_components/' + filename)
    end.join
  end

  def bower_javascript
    bower_yaml.fetch('bower_components').fetch('js').map do |filename|
      File.read('bower_components/' + filename)
    end.join
  end

  def vendor_javascript
    bower_yaml.fetch('vendor').fetch('javascript').map do |filename|
      vendor_file = 'vendor/' + filename
      next unless File.file? vendor_file
      File.read(vendor_file)
    end.join +

    bower_yaml.fetch('vendor').fetch('coffee').map do |filename|
      vendor_file = 'vendor/' + filename
      next unless File.file? vendor_file
      CoffeeScript.compile(File.read('vendor/' + filename))
    end.join
  end

  def bower_yaml
    YAML.load(File.read('vendor_and_bower_components.yaml'))
  end
end
