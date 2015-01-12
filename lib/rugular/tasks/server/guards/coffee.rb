require 'guard'
require 'guard/plugin'

module Guard
  class RugularCoffeeScript < Plugin
    def start; true end
    def stop; true end
    def reload; true end
    def run_all
      CoffeeScript.compile

    end

    def run_on_change
    end
  end
end
