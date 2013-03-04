require 'spec_helper'
require 'grim_repo/forks'

describe GrimRepo::Forks do
  let(:client) { double('Client') }
  let(:repository) { double('Repository', full_name: 'example/test') }

  describe "#initialize" do
    it "takes a client & repository" do
      forks = GrimRepo::Forks.new(client, repository)
      forks.client.should == client
      forks.repository.should == repository
    end
  end

  describe "fetching" do
    # Assuming 1 repository per page.
    let(:page1_uri) { URI.parse('https://api.github.com/repos/example/test/forks') }
    let(:page2_uri) { URI.parse('https://api.github.com/repos/example/test/forks?page=2') }

    let(:page1_response) { double('response-1', env: {links: {'next' => page2_uri}}) }
    let(:page2_response) { double('response-2', env: {links: {}}) }

    let(:page1_body) { [fork1] }
    let(:page2_body) { [fork2] }

    let(:fork1) { {'name' => 'Forked-Repository-1'} }
    let(:fork2) { {'name' => 'Forked-Repository-2'} }

    let(:forks) { GrimRepo::Forks.new(client, repository) }

    before do
      client.stub!(:get).with(page1_uri).and_yield(page1_response).and_return(page1_body)
      client.stub!(:get).with(page2_uri).and_yield(page2_response).and_return(page2_body)
    end

    it "requests only the first page if enough repositories are available" do
      client.should_receive(:get).with(page1_uri)
      client.should_not_receive(:get).with(page2_uri)

      forks.take(1)
    end

    it "requests all the pages to fetch all repositories" do
      client.should_receive(:get).with(page1_uri)
      client.should_receive(:get).with(page2_uri)

      forks.to_a
    end

    it "yields GrimRepo::Repository instances" do
      forks.each do |fork|
        fork.should be_instance_of(GrimRepo::Repository)
      end
    end
  end
end
