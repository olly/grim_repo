require 'spec_helper'
require 'grim_repo'

describe "retrieving the client's user", type: :feature, cassette: 'client_user' do
  subject { client.user }

  it { should be_instance_of(GrimRepo::User) }
  its(:login) { should == 'grimrepo' }
end
