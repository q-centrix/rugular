require 'bundler/gem_tasks'
require 'rubygems'

Dir.glob("#{__dir__}/lib/**/*.rb").each { |file| require file }

require 'cucumber'
require 'cucumber/rake/task'

task default: %i(features)

Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "features --format pretty"
end
