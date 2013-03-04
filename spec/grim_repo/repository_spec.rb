require 'spec_helper'
require 'grim_repo/repository'

describe GrimRepo::Repository, fixtures: true do
  let(:client) { mock('Client') }
  let(:repository) { GrimRepo::Repository.new(client, fixture('repository.json')) }

  describe "#initialize" do
    subject { repository }

    its(:name) { should == 'Hello-World' }
  end
end
