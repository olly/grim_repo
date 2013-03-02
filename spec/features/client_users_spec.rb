require 'spec_helper'
require 'grim_repo'

describe "retrieving a specific user", type: :feature, cassette: 'client_users' do
  context "with a user that exists" do
    subject { client.users('olly') }
    
    it { should be_instance_of(GrimRepo::User) }
    its(:id) { should == 630 }
    its(:login) { should == 'olly' }
  end

  context "with a user that doesn't exist" do
    subject { client.users('username-cdeab409-3717-4983-8cd6-999100b36d9e') }

    it { should be_nil }
  end
end
