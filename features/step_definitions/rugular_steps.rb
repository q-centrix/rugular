When (/^I set up Rugular and run "(.*?)"$/) do |command|
  system("cd tmp/aruba && rugular new my-app && cd my-app && #{command}")
end

When (/^I set up Rugular with dependencies and run "(.*?)"$/) do |command|
  system(
    "cd tmp/aruba && rugular new my-app "\
    "&& cd my-app && rugular dependencies && "\
    "#{command}"
  )
end
