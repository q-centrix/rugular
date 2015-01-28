require 'haml'

class RugularHaml
  def self.compile(haml_file)
    new(haml_file).compile
  end

  def initialize(haml_file)
    @haml_file = haml_file
    @html = ::Haml::Engine.new(File.read(haml_file)).render
  end

  def compile
    write_dist_index_html_file if haml_file.include? 'src/index.haml'

    write_tmp_file

    message = "Successfully compiled #{haml_file} to html!\n"
  end

  private

  attr_reader :haml_file, :html

  def tmp_file
    haml_file.gsub('src', '.tmp').gsub('haml', 'html')
  end

  def write_dist_index_html_file
    File.open('dist/index.html', 'w', &write_html)
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
