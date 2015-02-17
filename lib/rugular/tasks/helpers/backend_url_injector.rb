module Rugular
  class BackendURLInjector
    include Thor::Shell

    def self.inject_urls(config_file:, environment:)
      new(
        config_file: config_file,
        constant_file: constant_file,
        environment: environment
      ).inject_urls
    end

    def new(config_file:, constant_file:, environment:)
      @config_file = config_file
      @constant_file = constant_file
      @environment = environment
    end

    def inject_urls
      IO.write('', File.open do |file|
        file.read.gsub(
          authentication_url_text, authentication_url
        ).gsub(
          authorization_url_text, authorization_url
        ).gsub(
          api_url_test, api_url
        )
      end)
    end

    private

    attr_reader :config_file, :constant_file, :environment

    def authentication_url_text
      'Declare the authentication_url in the config.yaml, '\
        'Rugular will fill this in for you'
    end

    def authorization_url_text
      'Declare the authorization_url in the config.yaml, '\
        'Rugular will fill this in for you'
    end

    def api_url_text
      'Declare the api_url in the config.yaml, '\
        'Rugular will fill this in for you'
    end

    def backend_yaml
      ERB.new(pathname.read).result
    end

    def authentication_url
      backend_yaml.fetch(environment).fetch(:authentication_url)
    end

    def authorization_url
      backend_yaml.fetch(environment).fetch(:authorization_url)
    end

    def api_url
      backend_yaml.fetch(environment).fetch(:api_url)
    end
  end
end
