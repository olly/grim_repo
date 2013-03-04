require 'json'

module FixtureSupport
  def fixture(filename)
    file = Pathname.new(__dir__).join('..', 'fixtures', 'data', filename)
    JSON.parse(file.read)
  end
end
