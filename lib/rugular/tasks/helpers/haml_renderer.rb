require 'haml'
require 'action_view'

module Rugular
  class HamlRenderer
    include ActionView::Helpers::AssetTagHelper

    def self.render(file)
      new(file).render
    end

    def initialize(file)
      @file = file
    end

    def render
      Haml::Engine.new(file.read).render(get_binding)
    end

    private

    attr_accessor :file

    def get_binding
      @_binding ||= binding
    end

    # Override Action View to exclude the 'stylesheets' folder.
    def stylesheet_link_tag(*sources)
      options = sources.extract_options!.stringify_keys
      path_options = options.extract!('protocol').symbolize_keys
      copy_bower_files(
        sources.select { |source| source.match('bower_component') }
      )

      sources.uniq.map { |source|
        tag_options = {
          "rel" => "stylesheet",
          "media" => "screen",
          "href" => source.gsub('.tmp/', '')
        }.merge!(options)
        tag(:link, tag_options)
      }.join("\n").html_safe

    end

    # Override Action View to exclude the 'javascripts' folder.
    def javascript_include_tag(*sources)
      options = sources.extract_options!.stringify_keys
      path_options = options.extract!('protocol', 'extname').symbolize_keys
      copy_bower_files(
        sources.select { |source| source.match('bower_component') }
      )

      sources.uniq.map { |source|
        tag_options = {
          "src" => source.gsub('.tmp/', '')
        }.merge!(options)
        content_tag(:script, "", tag_options)
      }.join("\n").html_safe
    end

    def copy_bower_files(bower_components)
      bower_components.each do |bower_component|
        FileUtils.mkdir_p(
          File.dirname(bower_component.gsub('bow', '.tmp/bow'))
        )
        FileUtils.cp_r(
          bower_component, bower_component.gsub('bow', '.tmp/bow')
        ) if File.file?(bower_component)
      end
    end

  end
end
