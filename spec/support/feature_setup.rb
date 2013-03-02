require 'active_support/concern'

module FeatureSetup
  extend ActiveSupport::Concern

  included do
    let(:client_username) { ENV['GRIMREPO_TEST_USERNAME'] }
    let(:client_password) { ENV['GRIMREPO_TEST_PASSWORD'] }
    let(:client) { GrimRepo::Client.new(client_username, client_password) }
  end
end
