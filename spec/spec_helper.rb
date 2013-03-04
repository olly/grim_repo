require 'pathname'
root = Pathname.new(File.join(__dir__, '..'))

$LOAD_PATH.unshift root.join('lib')

Dir[root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.order = 'random'

  config.include FeatureSetup, type: :feature
  config.include FixtureSupport, fixtures: true
end
