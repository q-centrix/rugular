When (/^I set up Rugular and run "(.*?)"$/) do |command|
  system("cd tmp/aruba && rugular new my-app && cd my-app && #{command}")
end
