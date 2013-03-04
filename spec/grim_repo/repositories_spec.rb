require 'spec_helper'
require 'grim_repo/repositories'

describe GrimRepo::Repositories do
  let(:client) { double('Client') }
  let(:user) { double('User', login: 'test') }

  describe "#initialize" do
    it "takes a client & user" do
      repositories = GrimRepo::Repositories.new(client, user)
      repositories.client.should == client
      repositories.user.should == user
    end
  end

  describe "fetching" do
    # Assuming 1 repository per page.
    let(:page1_uri) { URI.parse('https://api.github.com/users/test/repos')}
    let(:page2_uri) { URI.parse('https://api.github.com/users/test/repos?page=2')}
    let(:page3_uri) { URI.parse('https://api.github.com/users/test/repos?page=3')}

    let(:page1_response) { double('response-1', env: {links: {'next' => page2_uri}}) }
    let(:page2_response) { double('response-2', env: {links: {'next' => page3_uri}}) }
    let(:page3_response) { double('response-3', env: {links: {}}) }

    let(:page1_body) { [repository1] }
    let(:page2_body) { [repository2] }
    let(:page3_body) { [repository3] }

    let(:repository1) { {'name' => 'Repository-1'} }
    let(:repository2) { {'name' => 'Repository-2'} }
    let(:repository3) { {'name' => 'Repository-3'} }

    let(:repositories) { GrimRepo::Repositories.new(client, user) }

    before do
      client.stub!(:get).with(page1_uri).and_yield(page1_response).and_return(page1_body)
      client.stub!(:get).with(page2_uri).and_yield(page2_response).and_return(page2_body)
      client.stub!(:get).with(page3_uri).and_yield(page3_response).and_return(page3_body)
    end

    it "requests only the first page if enough repositories are available" do
      client.should_receive(:get).with(page1_uri)
      client.should_not_receive(:get).with(page2_uri)
      client.should_not_receive(:get).with(page3_uri)

      repositories.take(1)
    end

    it "requests all the pages to fetch all repositories" do
      client.should_receive(:get).with(page1_uri)
      client.should_receive(:get).with(page2_uri)
      client.should_receive(:get).with(page3_uri)

      repositories.to_a
    end

    it "yields GrimRepo::Repository instances" do
      repositories.each do |repository|
        repository.should be_instance_of(GrimRepo::Repository)
      end
    end
  end
end
