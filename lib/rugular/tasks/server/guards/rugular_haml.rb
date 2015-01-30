require 'haml'

class RugularHaml
  def self.compile(haml_file)
    new(haml_file).compile
  end

  def self.delete(haml_file)
    new(haml_file).delete
  end

  def initialize(haml_file)
    @haml_file = haml_file
  end

  def compile
    write_tmp_file

    "Successfully compiled #{haml_file} to html!\n"
  end

  def delete
    FileUtils.rm(tmp_file)

    "Sucessfully removed #{tmp_file}\n"
  end

  private

  def html
    @_html ||= ::Haml::Engine.new(File.read(haml_file)).render
  end

  attr_reader :haml_file

  def tmp_file
    haml_file.gsub('src', '.tmp').gsub('haml', 'html')
  end

  def write_tmp_file
    create_tmp_folder

    File.open(tmp_file, 'w', &write_html)
  end

  def write_html
    ->(file) { file.write html }
  end

  def create_tmp_folder
    dirname = File.dirname(tmp_file)

    FileUtils.mkdir_p(dirname) unless File.directory? dirname
  end
end
