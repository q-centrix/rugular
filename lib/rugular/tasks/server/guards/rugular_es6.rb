require 'babel/transpiler'

class RugularES6
  def self.compile(es6_file)
    new(es6_file).compile
  end

  def self.delete(es6_file)
    new(es6_file).delete
  end

  def initialize(es6_file)
    @es6_file = es6_file
  end

  def compile
    write_tmp_file

    "Successfully compiled #{es6_file} to html!\n"
  end

  def delete
    FileUtils.rm(tmp_file)

    "Sucessfully removed #{tmp_file}\n"
  end

  private

  attr_reader :es6_file

  def javascript
    @_javascript ||= Babel::Transpiler.transform File.read(es6_file)
  end

  def tmp_file
    es6_file.gsub('src', '.tmp').gsub('es6', 'js')
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
