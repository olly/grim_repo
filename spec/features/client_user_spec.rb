require 'spec_helper'
require 'grim_repo'

describe "retriving the client's user", type: :feature do
  subject { client.user }

  it { should be_instance_of(GrimRepo::User) }
  its(:login) { should == 'grimrepo' }
end
