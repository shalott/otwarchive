# A monkeypatch for authlogic so that javascript scenarios can actually run in test
# See: http://stackoverflow.com/questions/10775472/authlogic-with-capybara-cucumber-selenium-driver-not-working
#
if ENV["RAILS_ENV"] == "test"

  module Authlogic
    module Session
      module Activation
        module ClassMethods
          def controller
            if !Thread.current[:authlogic_controller]
              Thread.current[:authlogic_controller] = Authlogic::TestCase::MockController.new
            end
            Thread.current[:authlogic_controller]
          end
        end
      end
    end
  end

end
