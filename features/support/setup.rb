Dir.glob("#{__dir__}/**/*.rb").each { |file| require file }
require 'aruba/cucumber'
