require 'nokogiri'
require_relative '../../helpers/javascript_files'

class RugularIndexHtml
  def self.update_javascript_script_tags
    new.update_javascript_script_tags
  end

  def initialize; end

  def update_javascript_script_tags
    remove_application_javascript_tags

    add_javascript_files

    File.open('.tmp/index.html', 'w') { |file| file.write application_html }
  end

  private

  def remove_application_javascript_tags
    application_javascript_node.children.remove
  end

  def add_javascript_files
    application_javascript_node.children = javascript_file_script_tags
  end

  def javascript_file_script_tags
    Nokogiri::XML::NodeSet.new(
      application_html,
      Rugular::JavascriptFiles.ordered_array.map(&convert_to_script_tag)
    )
  end

  def convert_to_script_tag
    lambda do |javascript_file|
      tmp_filename = javascript_file.gsub('src', '').gsub(/coffee|es6/, 'js')

      Nokogiri::XML::Node.new 'script', application_html do |node|
        node['src'] = tmp_filename
      end
    end
  end

  def application_html
    @_html ||= Nokogiri::HTML(File.read('.tmp/index.html'))
  end

  def application_javascript_node
    application_html.at_css('.application_javascript')
  end
end
