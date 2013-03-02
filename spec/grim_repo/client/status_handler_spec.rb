require 'spec_helper'
require 'grim_repo/client/status_handler'

describe GrimRepo::Client::StatusHandler do
  let(:handler) { GrimRepo::Client::StatusHandler.new }

  def run
    handler.on_complete(env)
  end

  context "with a 200 response" do
    let(:env) { {status: 200} }

    it "shouldn't raise an error" do
      expect {
        run
      }.to_not raise_error
    end
  end

  context "with a 404 response" do
    let(:env) { {status: 404} }

    it "raises a GrimRepo::Client::NotFound error" do
      expect {
        run
      }.to raise_error(GrimRepo::Client::NotFound)
    end
  end
end
