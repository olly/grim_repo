require 'active_support/concern'
require 'vcr'

module FeatureSetup
  extend ActiveSupport::Concern

  FAKE_BASIC_AUTH = 'dXNlcm5hbWUtYWI1ZDAxMjUtMjYwYy00MTliLWI1NjgtNGY3MjVkMjA2NTZiOnBhc3N3b3JkLWIxNTc3MTM0LTk4MTEtNDk0MC05NjJhLWNhNTM2MzEyNDdlZA=='
  FAKE_USERNAME = 'username-ab5d0125-260c-419b-b568-4f725d20656b'
  FAKE_PASSWORD = 'password-b1577134-9811-4940-962a-ca53631247ed'

  included do
    username = ENV['GRIMREPO_TEST_USERNAME']
    password = ENV['GRIMREPO_TEST_PASSWORD']
    basic_auth = Base64.encode64("#{username}:#{password}").chomp

    VCR.configure do |config|
      config.before_record do |interaction|
        interaction.filter!(basic_auth, FAKE_BASIC_AUTH)
      end

      config.cassette_library_dir = File.join(__dir__, '..', 'fixtures', 'vcr')
      config.hook_into :faraday
    end

    let(:client) { GrimRepo::Client.new(username, password) }

    before(:all) { VCR.insert_cassette(self.class.metadata[:cassette]) }
    after(:all)  { VCR.eject_cassette }
  end
end
