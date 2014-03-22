# See https://blog.codecentric.de/en/2013/08/cucumber-capybara-poltergeist/

require 'rspec/expectations'
require 'capybara/cucumber'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(
    app,
    phantomjs: Phantomjs.path,
    #js_errors: false,
    #debug:       true,
    inspector:  true,
    window_size: [1280, 1024]
  )
end
Capybara.javascript_driver = :poltergeist
