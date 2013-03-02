require 'spec_helper'
require 'grim_repo'

describe "retrieving the client's user", type: :feature, cassette: 'client_user' do
  subject { client.user }

  it { should be_instance_of(GrimRepo::User) }

  its(:api_url) { should == URI.parse('https://api.github.com/users/grimrepo') }
  its(:avatar_url) { should == URI.parse("https://secure.gravatar.com/avatar/7d4abbc304f317d92aae5a6d87f2b0df?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png") }
  its(:created_at) { should == Time.utc(2013, 3, 1, 17, 16, 24) }
  its(:gravatar_id) { should == '7d4abbc304f317d92aae5a6d87f2b0df' }
  its(:id) { should == 3740564 }
  its(:login) { should == 'grimrepo' }
  its(:url) { should == URI.parse('https://github.com/grimrepo') }
end
