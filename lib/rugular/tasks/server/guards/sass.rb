require 'guard'
require 'guard/plugin'

module Guard
  class RugularSass < Plugin
    def initialize(opts = {})
    end

    def start; true end
    def stop; true end
    def reload; true end
    def run_all

    end

    def run_on_change

    end
  end
end

