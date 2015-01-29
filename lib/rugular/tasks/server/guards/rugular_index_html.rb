class RugularIndexHtml
  def self.update_javascript_script_tags
    new.update_javascript_script_tags
  end

  def initialize; end

  def update_javascript_script_tags
    IO.write('.tmp/index.html', File.open('.tmp/index.html') do |f|
      f.read.gsub(application_javascript_tag, javascript_file_script_tags)
    end)
  end

  private

  def application_javascript_tag
    "<script src='application.js'></script>"
  end

  def javascript_file_script_tags
    javascript_files.map(&convert_to_script_tag).join
  end

  def javascript_files
    Dir.glob("src/**/*.module.coffee").sort(&reverse_nested) +
      Dir.glob("src/**/*.routes.coffee").sort(&reverse_nested) +
      Dir.glob("src/**/*.factory.coffee").sort(&reverse_nested) +
      Dir.glob("src/**/*.controller.coffee").sort(&reverse_nested) +
      Dir.glob("src/**/*.directive.coffee").sort(&reverse_nested)
  end

  def reverse_nested
    lambda do |x, y|
      x.scan('/').length <=> y.scan('/').length
    end
  end

  def convert_to_script_tag
    lambda do |javascript_file|
      tmp_filename = javascript_file.gsub('src', '').gsub('coffee', 'js')

      "<script src='#{tmp_filename}'></script>\n"
    end
  end

end
