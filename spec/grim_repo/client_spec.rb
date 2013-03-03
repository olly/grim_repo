require 'spec_helper'
require 'grim_repo/client'

describe GrimRepo::Client do
  let(:client) { GrimRepo::Client.new('username', 'password') }
  let(:connection) { double('connection', get: response) }
  let(:response) { double('response') }
  before { client.stub!(:connection).and_return(connection) }

  describe "#initialize" do
    it "takes a username a password" do
      expect {
        GrimRepo::Client.new('username', 'password')
      }.to_not raise_error
    end
  end

  describe "#get" do
    let(:uri) { URI.parse('https://example.com/results?page=3')}
    let(:body) { "Lorum Ipsum" }
    before { response.stub!(:body).and_return(body) }

    it "performs a get request with the path & query" do
      connection.should_receive(:get).with('/results?page=3')

      client.get(uri)
    end

    context "with a block" do
      it "yields the response" do
        expect {|block|
          client.get(uri, &block)
        }.to yield_with_args(response)
      end
    end

    it "returns the response body" do
      result = client.get(uri)
      result.should == body
    end
  end
end
