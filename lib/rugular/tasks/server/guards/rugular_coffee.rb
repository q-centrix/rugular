require 'coffee_script'

class RugularCoffee
  def self.compile(coffee_file)
    new(coffee_file).compile
  end

  def self.delete(coffee_file)
    new(coffee_file).delete
  end

  def initialize(coffee_file)
    @coffee_file = coffee_file
  end

  def compile
    write_tmp_file

    "Successfully compiled #{coffee_file} to html!\n"
  end

  def delete
    FileUtils.rm(tmp_file)

    "Sucessfully removed #{tmp_file}\n"
  end

  private

  attr_reader :coffee_file

  def javascript
    @_javascript ||= CoffeeScript.compile(File.open(coffee_file))
  end

  def tmp_file
    coffee_file.gsub('src', '.tmp').gsub('coffee', 'js')
  end

  def write_tmp_file
    create_tmp_folder

    File.open(tmp_file, 'w', &write_javascript)
  end

  def create_tmp_folder
    dirname = File.dirname(tmp_file)

    FileUtils.mkdir_p(dirname) unless File.directory? dirname
  end

  def write_javascript
    ->(file) { file.write javascript }
  end
end
