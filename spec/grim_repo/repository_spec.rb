require 'spec_helper'
require 'json'
require 'grim_repo/repository'

describe GrimRepo::Repository do
  let(:client) { mock('Client') }
  let(:repository) { GrimRepo::Repository.new(client, fixture('repository.json')) }

  describe "#initialize" do
    subject { repository }

    its(:name) { should == 'Hello-World' }
  end

  def fixture(filename)
    file = Pathname.new(__dir__).join('..', 'fixtures', 'data', filename)
    JSON.parse(file.read)
  end
end
